# encoding: utf-8
require 'chinese_pinyin'

File.open(File.join(App.root, 'config', 'sensitive_word', 'chinese_sensitive.txt')).each_line do |line|
  word         = line.strip
  word_pinyin  = Pinyin.t(word, splitter: '')
  first_letter = word_pinyin[0].upcase
  SensitiveWord.create(word: word, word_pinyin: word_pinyin, first_letter: first_letter)
end
