class SensitiveWord < ActiveRecord::Base
  validates_uniqueness_of :word

  cattr_accessor :fast_trie
  cattr_accessor :trie_load

  self.fast_trie = ::Trie.new
  self.trie_load = false

  def self.load_words
    self.where('CHAR_LENGTH(word) > 1').find_each do |word|
      self.fast_trie.add word.word
    end
    self.trie_load = true
  end

  def self.trie_load?
    self.trie_load
  end

  def self.clear_words
    self.fast_trie = ::Trie.new
    self.trie_load = false
  end

  def self.reload_words
    self.clear_words
    self.load_words
  end

  def self.analyze(content)
    self.load_words if !self.trie_load?
    all_words(content)
  end

  # TODO
  # 实现方案，优化方案，可以先拆词，再遍历
  #   # 有多少词遍历多少次数据, 比如
  #     # 天安门
  #       # 安门
  #         # 门
  def self.all_words(str)
    word_arr ||= []
    str ||= ''
    str.length.times do |i|
      node = self.fast_trie.root
      length = 0
      str[i..-1].split('').each do |c|
        length += 1
        break unless node.walk!(c)
        word_arr.push str[i,length]  if node.terminal?
      end
    end
    word_arr
  end

end
