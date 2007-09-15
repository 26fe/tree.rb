# stdlib
require 'fileutils'

def recursive_run( dir, &block )
  block.call( dir )
  Dir.entries( dir ).each { |entry|
    next if entry == "." or entry == ".."
    next if not FileTest.directory?( dir + File::Separator + entry )
    next if $config.ignore_dir( entry )
    recursive_run( dir + File::Separator + entry, block )
  }  
end

def copy_dir( indir, outdir, re )
  if not File.directory?()
    raise "#{indir} is not a directory"
  end
  if not File.directory?( outdir )
    FileUtils.mkpath( outdir )
  end
  Dir.entries( indir ).each { |e| 
    if e.match( re ) 
      from = File.join( indir,  e )
      to   = File.join( outdir, e )
      # puts "#{from}  #{to}" 
      if File.exist?(to) and File.mtime(from) <= File.mtime(to)
        next
      end
      FileUtils.cp from, to
    end
  }
end

def copy_file( inpath, outdir )
  from = inpath
  to   = File.join( outdir, File.basename( from ) )
  # puts "#{from}  #{to}" 
  if File.exist?(to) and File.mtime(from) <= File.mtime(to)
    next
  end
  FileUtils.cp from, to
end
