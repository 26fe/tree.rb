#
# spec
#
begin
  require 'rspec/core/rake_task'
  RSpec::Core::RakeTask.new(:spec)

  RSpec::Core::RakeTask.new do |t|
    t.rspec_opts = ["--color", "--format", "spec", '--backtrace']
    t.pattern    = 'spec/**/*_spec.rb'
  end

rescue LoadError
  puts "rspec (or a dependency) not available. Install it with: sudo gem install rspec"
end


#
#
#begin
#  require 'rcov/rcovtask'
#  Rcov::RcovTask.new do |test|
#    test.libs << 'test'
#    test.pattern = 'test/**/*_test.rb'
#    test.verbose = true
#  end
#rescue LoadError
#  task :rcov do
#    abort "RCov is not available. In order to run rcov, you must: sudo gem install spicycode-rcov"
#  end
#end
#
#
