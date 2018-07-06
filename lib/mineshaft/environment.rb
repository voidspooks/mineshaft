# mineshaft
#
# author:: Cameron Testerman
# email:: cameronbtesterman@gmail.com
# created:: 2017-04-14 1:19PM
#
# Copyright (c) 2017-2018 Cameron Testerman

require 'fileutils'
require 'yaml'

module Mineshaft
  class Environment
    attr_reader :dir

    def initialize(dir, options)
      if options[:global]
        @dir = File.join(Dir.home, ".mineshaft", dir)
      else
        @dir = dir
      end
      @options = options
      @versions = YAML.load_file(File.join(File.dirname(File.expand_path(__FILE__)), '../../versions/versions.yaml'))
      @version = @options[:version] ? @options[:version] : Mineshaft::Constants::RUBY_VERSION_STABLE
    end

    def create
      FileUtils::mkdir_p(@dir)
      install_ruby
      if @options[:global]
        set_new_global @dir
      else
        create_template
      end
    end

    def use
      set_new_global
      puts "Now using the environment at: #@dir" 
    end

    private

    def install_ruby
      Mineshaft::Installer.new do |config|
        config.url = @versions[@version]
        config.directory = @dir
        config.version = @version
        config.options = @options
        config.global = @options[:global]
      end.run
    end

    def create_template
      template_file = File.open(File.join(File.dirname(File.expand_path(__FILE__)), '../../environment/activate.sh.erb'))
      Mineshaft::ActivateTemplate.new(@dir, template_file).create
    end

    def set_new_global
      if Dir["#{@dir}/bin/*"].length == 0
        puts "#@dir is not a valid environment - exiting" 
        exit
      end

      FileUtils.mkdir_p "#{Dir.home}/.mineshaft/bin"
      FileUtils.rm Dir.glob("#{Dir.home}/.mineshaft/bin/*")

      if File.readlines("#{Dir.home}/.bash_profile").grep(/mineshaft/).length == 0
        open("#{Dir.home}/.bash_profile", 'a') do |f|
          f.puts("PATH=#{Dir.home}/.mineshaft/bin:$PATH")
        end
      end

      Dir["#{@dir}/bin/*"].each do |binary_absolute|
        binary = binary_absolute.split("/").last
        FileUtils::ln_s binary_absolute, "#{Dir.home}/.mineshaft/bin/#{binary}" 
      end
    end
  end
end
