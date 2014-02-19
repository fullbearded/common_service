class CreateSensitiveWords < ActiveRecord::Migration
  def change
    create_table :sensitive_words, options: 'DEFAULT CHARSET=utf8' do |t|
      t.string :word, null: false 
      t.string :word_pinyin, null: false
      t.string :first_letter, limit: 1
    end
  end
end
