require 'rspec/core/rake_task'
require 'bundler/gem_tasks'

RSpec::Core::RakeTask.new(:spec) do |task|
  task.rspec_opts = ['--color']
end

task :build do
  %x{ rm mineshaft-*.gem }
  %x{ gem build mineshaft.gemspec }
end

task :install do
  %x{ yes | gem uninstall mineshaft }
  %x{ gem install ./mineshaft-*.gem }
end

task :default => :spec
task :test    => :spec
task :reload  => [ :build, :install ]
