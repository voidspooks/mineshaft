require 'rspec/core/rake_task'
require 'bundler/gem_tasks'
require 'net/http'

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

task :versions do
  rubyrepo = URI.parse("http://cache.ruby-lang.org/pub/ruby/")
  request = Net::HTTP::Get.new(rubyrepo.to_s)
  response = Net::HTTP.start(rubyrepo.host, rubyrepo.port) do |http|
    http.request(request)
  end 
  response
    .body
    .split(" ")
    .each do |directory|
      if directory.include?("href") and !directory.include?("zip") and !directory.include?("tar")
        puts directory
      end
    end
end

task :reset do
  if File.exist? "~/.mineshaft"
    %x{ rm -rf ~/.mineshaft }
    puts "Deleted ~/.mineshaft"
  else
    puts "~/.mineshaft does not exist. No changes made."
  end

  file_path = File.expand_path('~/.zshrc')
  lines = File.readlines(file_path)

  if lines.last.strip == "PATH=/Users/voidspooks/.mineshaft/bin:$PATH"
    lines.pop

    File.open(file_path, 'w') do |file|
      file.puts(lines)
    end
    puts "Removed 'PATH=/Users/voidspooks/.mineshaft/bin:$PATH' from ~/.zshrc"
  else
    puts "Last line did not match. No changes made."
  end
end

task :test    => :spec
task :cycle  => [ :build, :install ]
task :default => :cycle
