# coding: utf-8

require 'kconv'

module Windows::Net

 def each_share_folder(&block)
    result = `net share`.toutf8
    state = :prev_header
    result.each_line do |line|
      if line =~ /^-/
        state = :after_header
        next
      end

      # この正規表現. 共有名に空白が含まれると正しく
      # 処理できない。
      if state == :after_header and line =~ /^([^\s$]+)/
        share_name = $1.chomp
        if share_name.length > 0
          puts share_name
          # ここで失敗する。
          command = "net share #{share_name}"
          detail = `#{command.tosjis}`.toutf8
          parse_detail(detail, &block)
        end
      end
    end
  end

private
 def parse_detail(detail, &block)
    name = ""
    path = ""
    detail.each_line do |line|
      if line =~ /^共有名\s*(.*)/
        name = $1.chomp
      elsif line =~ /^パス\s*(.*)/
        path = $1.chomp 
      end
    end
    unless name.empty? or path.empty?
      block.call name, path if block
    end
 end
end


