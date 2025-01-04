# mineshaft
#
# author:: Cameron Testerman
# email:: cameronbtesterman@gmail.com
# created:: 2018-12-15 10:20PM
#
# © 2017 Cameron Testerman

require 'yaml'

module Mineshaft
  def self.env
    rubies = Dir["#{Mineshaft::Constants::GLOBAL_DIR}/*"]
    rubies.delete Mineshaft::Constants::GLOBAL_BIN

    puts "Globally installed Ruby versions"
    puts "--------------------------------"
    rubies.each { |ruby| puts ruby.split("/").last }
  end

  def self.environment(name, options)
    Mineshaft::Environment.new(name, options)
  end

  def self.new(name, options)
    environment(name, options).create
  end

  def self.use(name, options)
    environment(name, options).use
  end

  def self.reload
    ruby = File.readlink("#{Dir.home}/.mineshaft/bin/ruby").split('/')
    bin_dir = ruby.shift(ruby.length - 1).join("/")
    FileUtils.rm Dir.glob("#{Dir.home}/.mineshaft/bin/*")

    Dir["#{bin_dir}/*"].each do |binary_absolute|
      binary = binary_absolute.split("/").last
      FileUtils::ln_s binary_absolute, "#{Dir.home}/.mineshaft/bin/#{binary}" 
    end

    puts "Binaries successfully reloaded!"
  end

  def self.list
    versions = YAML.load_file(File.join(File.dirname(File.expand_path(__FILE__)), '../../versions/versions.yaml'))
    last_ten = []

    Hash[versions.sort_by {|k, v| -v }[versions.length - 10..versions.length]].each do |version, url|
      last_ten.push(version)
    end

    puts "Latest 10 Ruby versions available for download"
    puts "--------------------------------"
    last_ten.reverse.each {|ver| puts ver}
  end
end
