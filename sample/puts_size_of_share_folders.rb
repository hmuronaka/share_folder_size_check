# coding: utf-8

require 'kconv'
require '../windows/io/file_info.rb'
require '../windows/net/net_share.rb'

@nowtime = Time.new.strftime("%Y/%m/%d %H:%M")

Windows::Net.each_share_folder do |name,path|
  file_info = Windows::IO::FileInfo.get_info(path)
  return unless file_info

  puts <<STR
- name: #{name}
  path: #{path}
  size: #{file_info.size}
  count: #{file_info.count}
  datetime: #{@nowtime}
STR
end


