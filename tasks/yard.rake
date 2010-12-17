begin
  require 'yard'

  YARD::Rake::YardocTask.new do |t|
    t.files   = ['lib/**/*.rb']
    t.options = [
        '--readme', 'README.rdoc',
        # '--output-dir', 'doc/yardoc'
        '--any',
        '--extra',
        '--opts'
    ]
  end

rescue LoadError
  puts "Yard (or a dependency) not available. Install it with: sudo gem install jeweler"
end



# require 'hanna/rdoctask'
#require 'rake/rdoctask'
#require 'sdoc'
#
#Rake::RDocTask.new do |rdoc|
#  config = YAML.load(File.read('VERSION.yml'))
#  version = "#{config[:major]}.#{config[:minor]}.#{config[:patch]}"
#
#  rdoc.rdoc_dir = 'doc' # rdoc output folder
#  rdoc.title = "Tree Visitor #{version}"
#  rdoc.main = "README.rdoc" # page to start on
#
#  rdoc.rdoc_files.include('README*')
#  rdoc.rdoc_files.include('lib/**/*.rb')
#
#  # sdoc
#  rdoc.options << '--fmt' << 'shtml' # explictly set shtml generator
#  rdoc.template = 'direct' # lighter template used on railsapi.com
#end
