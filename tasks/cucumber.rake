require 'cucumber'
require 'cucumber/rake/task'

Cucumber::Rake::Task.new(:features) do |t|
  t.cucumber_opts = "--color --require features --format pretty features"
end
task :cucumber => :features
task :cuke => :features
