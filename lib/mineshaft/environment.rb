# mineshaft
#
# author:: Cameron Testerman
# email:: cameronbtesterman@gmail.com
# created:: 2017-04-14 1:19PM
#
# Copyright (c) 2017 Cameron Testerman

require 'fileutils'

module Mineshaft
  class Environment
    attr_reader :dir

    def initialize(dir, options)
      if options[:global]
        puts "GLOBAL!!!!!"
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
      install_ruby
      create_template
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
