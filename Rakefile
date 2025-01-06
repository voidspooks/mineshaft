# frozen_string_literal: true

require 'rspec/core/rake_task'
require 'bundler/gem_tasks'
require 'net/http'
require 'pry'

RSpec::Core::RakeTask.new(:spec) do |task|
  task.rspec_opts = ['--color']
end

task :build do
  `rm mineshaft-*.gem`
  `gem build mineshaft.gemspec`
end

task :install do
  `yes | gem uninstall mineshaft`
  `gem install ./mineshaft-*.gem`
end

task :versions do
  rubyrepo = URI.parse('http://cache.ruby-lang.org/pub/ruby/')
  request = Net::HTTP::Get.new(rubyrepo.to_s)
  response = Net::HTTP.start(rubyrepo.host, rubyrepo.port) do |http|
    http.request(request)
  end
  response
    .body
    .split(' ')
    .each do |directory|
      puts directory if directory.include?('href') && !directory.include?('zip') && !directory.include?('tar')
    end
end

task :reset do
  mineshaft_directory = File.expand_path('~/.mineshaft')
  if File.exist? mineshaft_directory
    `rm -rf #{mineshaft_directory}`
    puts "Deleted #{mineshaft_directory} and its contents."
  else
    puts "#{mineshaft_directory} does not exist. No changes made."
  end

  file_path = File.expand_path('~/.zshrc')
  lines = File.readlines(file_path)

  if lines.last.strip == 'PATH=/Users/voidspooks/.mineshaft/bin:$PATH'
    lines.pop

    File.open(file_path, 'w') do |file|
      file.puts(lines)
    end
    puts "Removed 'PATH=/Users/voidspooks/.mineshaft/bin:$PATH' from ~/.zshrc"
  else
    puts 'Last line did not match. No changes made.'
  end
end

task test: :spec
task rebuild: %i[build install]
task reload: %i[rebuild]
task cycle: %i[reset rebuild]
task default: :cycle
