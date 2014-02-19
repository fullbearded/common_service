require File.expand_path('../config/application', __FILE__)

require 'sinatra/base'

class MainApp < Sinatra::Base
  register Sinatra::ActiveRecordExtension
  register RailsConfig

  set :database, Settings.database.to_hash
  set :cache, Dalli::Client.new(Settings.memcached)

  set :public_folder, File.dirname(__FILE__) + '/public'
  set :views, App.root + '/app/views'

  post '/verify/sensitive_word' do
    @content = params[:content]
    if @content.present?
      @result = SensitiveWord.analyze(@content)
      if params[:filter]
        @result.sort{|a,b| b.size <=> a.size}.each do |wd|
          length = wd.length
          @content.gsub!(wd,'*'*length)
        end
      end
    end
    jbuilder :index
  end

end
