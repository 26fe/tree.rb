# -*- coding: utf-8 -*-
module TreeRb

  class DirCatVisitor < BasicTreeNodeVisitor

    CR = "\r"
    CLEAR = "\e[K"

    def initialize(out_filename, options = { })
      @start          = Time.now
      @bytes          = 0
      @entries        = Array.new
      @md5_to_entries = Hash.new
      @out_filename   = out_filename
      @verbose_level = 1
      @show_progress = true
    end

    def visit_leaf(filename)
      entry = DirCat::Entry.from_filename(filename)
      add_entry(entry)
      @bytes += entry.size
      if @verbose_level > 0
        print "#{CR}#{filename}#{CLEAR}"
      end
      if @show_progress
        sec = Time.now - @start
        print "#{CR}bytes: #{@bytes.to_human} time: #{sec} bytes/sec #{@bytes/sec} #{CLEAR}"
      end
    end

    #
    # add entry to this catalog
    # @private
    def add_entry(e)
      @entries.push(e)
      if @md5_to_entries.has_key?(e.md5)
        @md5_to_entries[e.md5].push(e)
      else
        @md5_to_entries[e.md5] = [e]
      end
    end

        # serialize catalog
    # @return [DirCatSer] serialized catalog
    def to_ser
      dircat_ser = DirCat::DirCatSer.new
      dircat_ser.dircat_version = DirCat::FORMAT_VERSION
      dircat_ser.dirname = @dirname
      dircat_ser.ctime = @ctime
      dircat_ser.entries = []
      @entries.each do |entry|
        dircat_ser.entries << entry.to_ser
      end
      dircat_ser
    end


        #
    # Save serialized catalog to file
    # @param [String,File] file
    def save_to
      if @out_filename.kind_of?(String)
        begin
          File.open(@out_filename, "w") do |f|
            f.puts to_ser.to_yaml
          end
        rescue Errno::ENOENT
          raise DirCatException.new, "DirCat: cannot write into '#{file}'", caller
        end
      else
        @out_filename.puts to_ser.to_yaml
      end
    end


  end
end
