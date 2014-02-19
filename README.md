# 通用服务

## 敏感词检测

#### Trie

Trie，又成前缀树或字典树，是一种有序树，用于保存关联数组，其中的键通常是字符串.与二叉查找树不同，键不是直接保存在节点中，而是由节点在树中的位置决定。一个节点的所有子孙都有相同的前缀，也就是这个节点对应的字符串，而根节点对应空字符串。一般情况下，不是所有的节点都有对应的值，只有叶子节点和部分内部节点所对应的键才有相关的值。

概念参考：http://zh.wikipedia.org/wiki/Trie


#### 使用
初始化数据库
<pre>
bundle install
# 创建数据库并修改config/settings.yml数据库配置
rake db:migrate
rake db:seed
</pre>


启动： RACK_ENV=productin rackup config.ru
<pre>
  $  curl -d 'content=天安门' http://127.0.0.1:9292/verify/sensitive_word
  $  {"ret":1,"response":["天安门"],"total":1}
  
  $ curl -d 'content=中国人你动的法轮功你的&filter=true' http://127.0.0.1:9292/verify/sensitive_word
  $ {"ret":1,"response":["法轮","法轮功","轮功"],"total":3,"content=":"中国人你动的***你的"}
</pre>

#### 参考

https://github.com/witgo/fast_trie

注：gem 'fast_trie', git: 'https://github.com/witgo/fast_trie.git', require: 'trie'

需要指定gem包, 原有的fast_trie是不支持中文的

#### 敏感词库

敏感词库在<code>config/sensitive_word/chinese_sensitive.txt</code> 可以将你收集的敏感词写入

