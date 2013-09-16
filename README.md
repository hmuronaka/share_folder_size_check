Net Share for Ruby
======================
Windows XP/2003の net shareコマンドの内容をrubyで扱えるようにする。
net shareは、そのＰＣ上の共有フォルダの一覧を表示するコマンド。

# API

## Windows::Net::each_share_folder(&block)
ＰＣ上の共有フォルダの各情報(共有ファイル名、パス）をブロックに渡す。

利用例 (folder_size_check.rb参照)
```ruby
require './Windows/net/net_share.rb'
Windows::Net.each_share_folder do |name,path|
  puts <<STR
- name: #{name}
  path: #{path}
STR
end
```

## Windows::IO::FileInfo::get_info(path)
Pathのファイルサイズと数を取得する。Dirコマンドを利用している。

利用例
```ruby
require './Windows/io/file_info.rb'
fileinfo = Windows::IO::FileInfo.get_info('/a/b/')
puts fileinfo.to_s
```

# 問題点
共有ファイル名に空白がある場合は、正しく処理できないバグがあります。

