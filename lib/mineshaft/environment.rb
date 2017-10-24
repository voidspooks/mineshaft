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
      @dir = dir
      @options = options
    end

    def create
      FileUtils::mkdir_p(@dir)
      versions = YAML.load_file(File.join(File.dirname(File.expand_path(__FILE__)), '../../versions/versions.yaml'))
      version = @options[:version] ? @options[:version] : Mineshaft::Installer.get_latest_stable
      installer = Mineshaft::Installer.new do |config|
        config.url = versions[version]
        config.directory = @dir
        config.version = version
      end
      installer.run
    end
  end
end
