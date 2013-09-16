# coding: utf-8
require 'kconv'

module Windows::IO

  class FileInfo

    attr_reader :size, :count
    
    def initialize(size = 0, count = 0)
      @size = size
      @count = count
    end
	
    def equals(other)
      @size ==  other.size and @count == other.count
    end
    
    def empty?
      @size == 0 or @count == 0
    end
    
    def self.get_info(path)
      command = "dir #{path} /s /a-d"
    
      puts command.tosjis
      output = `#{command.tosjis}`.toutf8
      result = nil
      
      index = output.rindex("ファイルの総数:")
      if index != nil
        last_output = output.slice(index, output.size - index)
        if last_output =~ /([\d,]+)\s*個のファイル\s*([\d,]+)\s*バイト/
          result = FileInfo.new($2.delete(',').to_i, $1.delete(',').to_i)
        else
          raise "failed get_info #{path}."
        end
      end
      result
    end
    
    def to_s
      "size => #{@size}, count => #{@count}"
    end

  end
end
