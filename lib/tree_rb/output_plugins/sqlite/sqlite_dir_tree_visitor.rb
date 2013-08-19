# -*- coding: utf-8 -*-
module TreeRb

  class SqliteDirTreeVisitor < BasicTreeNodeVisitor

    def initialize(filename)
      @db = SQLite3::Database.new(filename)
      @db.execute('create table files(path varchar(1024), name varchar(40), size integer, sha1 varchar(40))')
    end

    def visit_leaf(pathname)
      puts pathname
      stat = File.lstat(pathname)
      digest = SHA1.file(pathname).hexdigest
      sql = 'insert into files (path, name, size, sha1) values ('
      sql << "\"#{File.dirname(pathname)}\","
      sql << "\"#{File.basename(pathname)}\","
      sql << "\"#{stat.size}\","
      sql << "\"#{digest}\")"
      @db.execute(sql)

      # entry = Entry.from_filename(filename)
      # me.add_entry(entry)
      # bytes += entry.size
      # if me.verbose_level > 0
      #   print "#{CR}#{filename}#{CLEAR}"
      # end
      # if me.show_progress
      #   sec = Time.now - start
      #   print "#{CR}bytes: #{bytes.to_human} time: #{sec} bytes/sec #{bytes/sec} #{CLEAR}"
      # end
      # content   = ContentFile.new(pathname, @options)
      # connect the leaf_node created to the last tree_node on the stack
      # nr_files += 1
      # LeafNode.new(content, @stack.last)
    end

    def find_duplicates
      # Loop through digests.
      @db.execute('select sha1,count(1) as count from files group by sha1 order by count desc').each do |row|
        if row[1] > 1 # Skip unique files.
          puts 'Duplicates found:'
          digest = row[0]
          # List the duplicate files.
          db.execute("select digest,path from files where digest='#{digest}'").each do |dup_row|
            puts "[#{digest}] #{dup_row[1]}"
          end
        end
      end
    end

  end
end # end module TreeVisitor
