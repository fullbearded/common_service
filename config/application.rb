require 'rubygems'
require 'bundler'

Bundler.require(:default)

# console 中的reload
require "active_support/dependencies"
require "active_support/core_ext/object/blank"
require 'sinatra/jbuilder'

module App
  def self.environment
    ENV['RACK_ENV'] ||= 'development'
  end

  def self.root
    File.expand_path('../../', __FILE__)
  end
  
  def self.logger
    @logger ||= begin
                  require 'fileutils'
                  path = File.join(App.root, "log/#{environment}.log")
                  FileUtils.mkdir_p(File.dirname(path))
                  Logger.new(path)
                end
  end
end

%w|lib app/models|.each do |path|
  ActiveSupport::Dependencies.autoload_paths.push "#{App.root}/#{path}"
end

current_environment = File.join(App.root, "config/environments/#{App.environment}")
require current_environment if File.exists? current_environment

