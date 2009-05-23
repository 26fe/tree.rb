#
# substitute into a file
#
def subfile( filename, map )
  lines = IO.readlines( filename)
  if $options.backup
    FileUtils.mv( filename, filename + ".bck" )
  end

  lines.each_with_index { |l,i|
    map.each { |l1, l2|
      #puts "#{l} #{l1} #{l.index(l1)}"
      if l.index( l1 ) == 0
        puts "subst #{l1}"
        lines[i] = l2
      end
    }
  }

  File.open( filename,  "w" ) { |f|
    lines.each{ |l| f.puts l }
  }
  puts "patched #{filename}"

rescue Errno::ENOENT => e
  puts "file not found '#{filename}'"
end
