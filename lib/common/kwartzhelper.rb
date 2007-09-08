# ruby gems
require "rubygems"
require "kwartz"
require "kwartz/main"

#
# kwartz utility
#
# TODO: compilare i file controllando le date
def compile( template_dir, template_include_dir, template_out_dir )

  incs = []
  if File.directory?( template_include_dir ) 
    incs = Dir.new( template_include_dir ).find_all { |f| f =~ /\.html$/ }
    incs = incs.map{ |f| File.join(template_include_dir, f) }.join(",")
  end
  
  Dir.foreach( template_dir ) { |f|
    next unless f =~ /.html$/
    inpath = File.join(template_dir, f)
    outpath = File.join( template_out_dir, f.sub( /.html$/, ".rb" ) )
    plogicpath = template_dir + File::Separator + f.sub( /.html$/, ".plogic" )

    argv = %w[--delspan -a defun -l ruby -i]
    argv.push( incs )

    if File.exist?( plogicpath )
      argv.push( "-p", plogicpath )
    end
    argv.push( inpath )

    puts "kwartz " + argv.join(" ")
    main = Kwartz::Main.new(argv)
    output = main.execute()
    File.open(outpath, 'w') { |f| f.write(output) }
  }
end

