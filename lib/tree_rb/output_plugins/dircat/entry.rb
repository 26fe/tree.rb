# -*- coding: utf-8 -*-
module DirCat

  FORMAT_VERSION="0.2.1"

  class EntrySer < OpenStruct
  end

  class DirCatSer < OpenStruct
  end

  class DirCatException < RuntimeError
  end

  #
  # Entry
  #
  class Entry

    # TODO: must be attr_reader
    attr_accessor :md5
    attr_accessor :name
    attr_accessor :path
    attr_accessor :size
    attr_accessor :mtime

    def self.from_filename(filename)
      entry       = new
      entry.name  = File.basename(filename)
      entry.path  = File.dirname(filename)
      stat        = File.lstat(filename)
      entry.size  = stat.size
      entry.mtime = stat.mtime
      # self.md5 = Digest::MD5.hexdigest(File.read( f ))
      entry.md5 = MD5.file(filename).hexdigest unless stat.symlink?
      entry
    end

    def self.from_ser(entry_ser)
      entry       = new
      entry.md5   = entry_ser.md5
      entry.name  = entry_ser.name
      entry.path  = entry_ser.path
      entry.size  = entry_ser.size
      entry.mtime = entry_ser.mtime
      entry
    end

    def to_ser
      entry_ser       = EntrySer.new
      entry_ser.md5   = @md5
      entry_ser.name  = @name
      entry_ser.path  = @path
      entry_ser.size  = @size
      entry_ser.mtime = @mtime
      entry_ser
    end

    def to_s
      @md5 + "  " + @name + "\t " + @path + "\n"
    end

  end

end
