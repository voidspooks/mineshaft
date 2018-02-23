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
      @version = @options[:version] ? @options[:version] : Mineshaft::Installer.get_latest_stable
    end

    def create
      FileUtils::mkdir_p(@dir)
      FileUtils::mkdir_p("#{Dir.home}/.mineshaft/bin")
      install_ruby
      create_template
    end
    
    # TODO: PATH should be set instead to ~/.mineshaft/bin. 
    # Inside .mineshaft/bin will be symbolic links to the
    # proper Ruby global environment.
    def set_global_ruby
      puts "Setting #{@version} as the global ruby version"
      if File.readlines("#{Dir.home}/.bash_profile").grep(/mineshaft/).size > 0
        f = File.open("#{Dir.home}/.bash_profile", "a")
        f.write("export PATH=#{Dir.home}/.mineshaft/bin:$PATH")
        f.close
      end
      binaries = Dir["#{@dir}/bin"]
      puts binaries
    end

    private

    def install_ruby
      Mineshaft::Installer.new do |config|
        config.url = @versions[@version]
        config.directory = @dir
        config.version = @version
        config.options = @options
      end.run
    end

    def create_template
      template_file = File.open(File.join(File.dirname(File.expand_path(__FILE__)), '../../environment/activate.sh.erb'))
      Mineshaft::ActivateTemplate.new(@dir, template_file).create
    end
  end
end
