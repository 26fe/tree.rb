# ruby gems
require "rubygems"
require "kwartz"
require "kwartz/main"

#
# kwartz utility
#
def compile( template_dir, template_include_dir, template_out_dir )
  
  re_templatefile = /^[^\.](.+).html$/ 

  maxtime = Time.local( 1980 ) 
  incs = []
  if File.directory?( template_include_dir ) 
    incs = Dir.new( template_include_dir ).find_all { |f| f =~ re_templatefile }
    incs = incs.map{ |f| File.join(template_include_dir, f) }
    maxtime_incs = incs.inject(maxtime) {|t,f| 
      t1 = File.mtime( f ) 
      if t1 > t then t1 else t end
    }
    incs = incs.join(",")
  end
  
  Dir.foreach( template_dir ) { |f|
    next unless f =~ re_templatefile
    inpath = File.join(template_dir, f)
    inpath_time = File.mtime( inpath )

    plogicpath = template_dir + File::Separator + f.sub( /.html$/, ".plogic" )
    plogic_time = Time.local( 1980 )
    
    outpath = File.join( template_out_dir, f.sub( /.html$/, ".rb" ) )
    outpath_time = Time.local( 1980 )
    if File.exist?( outpath )
      outpath_time = File.mtime( outpath )
    end
    
    argv = %w[--delspan -a defun -l ruby -i]
    argv.push( incs )

    if File.exist?( plogicpath )
      argv.push( "-p", plogicpath )
      plogicpath_time = File.mtime( plogicpath )
    end
    argv.push( inpath )

    if outpath_time < maxtime_incs or outpath_time < inpath_time or outpath_time < plogicpath_time 
      puts "kwartz " + argv.join(" ")
      main = Kwartz::Main.new(argv)
      output = main.execute()
      File.open(outpath, 'w') { |f| f.write(output) }      
    end
  }
end

