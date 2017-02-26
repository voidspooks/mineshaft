require 'rspec/core/rake_task'
require 'bundler/gem_tasks'

RSpec::Core::RakeTask.new(:spec) do |task|
  task.rspec_opts = ['--color']
end

task :build do
  %x{ rm ruby-venv-*.gem }
  %x{ gem build ruby-venv.gemspec }
end

task :install do
  %x{ yes | gem uninstall ruby-venv }
  %x{ gem install ./ruby-venv-*.gem }
end

task :default => :spec
task :reload  => [ :build, :install ]
