namespace :tree_rb do
  #
  # examples
  #
  desc 'run all tree.rb example'
  task :examples do

    Dir['examples/*.rb'].sort.each do |filename|
      next unless filename =~ /\d\d.+\.rb$/
      unless system "ruby #{filename}"
        exit
      end
    end
    puts "All examples run successfully"

  end

  desc "Start an IRB shell"
  task :shell do
    sh 'IRBRC=`pwd`/config/irbrc.rb irb'
  end
end
