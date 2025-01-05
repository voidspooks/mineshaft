# frozen_string_literal: true

# author:: Cameron Testerman
# email:: cameronbtesterman@gmail.com
# created:: 2018-12-15 10:20PM

# Copyright (c) 2017 Cameron Testerman
#
# Permission is hereby granted, free of charge, to any person obtaining a copy of this software
# and associated documentation files (the “Software”), to deal in the Software without
# restriction, including without limitation the rights to use, copy, modify, merge, publish,
# distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the
# Software is furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all copies or
# substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED “AS IS”, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
# THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR
# OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
# ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
# OTHER DEALINGS IN THE SOFTWARE.

require 'yaml'

module Mineshaft
  class Commands
    AVAILABLE_COMMANDS = [
      'env',
      'install',
      'environment',
      'new_env',
      'use',
      'reload',
      'list',
      'version',
      'help'
    ]

    @options = {
      openssl_dir: '/opt/homebrew/opt/openssl',
      version: RUBY_VERSION,
      global: false,
      verbose: false
    }

    @logger = Mineshaft::Logger

    def self.options
      @options
    end
  
    def self.options=(value)
      @options = value
    end

    def options
      self.class.options
    end

    @help = nil

    def self.help
      @logger.log @help
    end

    def self.help=(value)
      @help = value
    end

    def help
      self.class.help
    end

    def self.env
      rubies = Dir["#{Mineshaft::Constants::GLOBAL_DIR}/*"]
      rubies.delete Mineshaft::Constants::GLOBAL_BIN
  
      puts 'Globally installed Ruby versions'
      puts '--------------------------------'
      rubies.each { |ruby| puts ruby.split('/').last }
    end

    def self.install
      options[:global] = true
    
      if ARGV[1]
        options[:version] = ARGV[1] if ARGV[1]
        name = options[:version]
      else
        name = RUBY_VERSION
      end
    
      COMMANDS.new(name:)
    end
  
    def self.environment(name, options)
      Mineshaft::Environment.new(name, options)
    end
  
    def self.new(name: nil)
      if name.nil?
        name = ARGV[ARGV.index('new') + 1]
      end
      
      options[:version] = ARGV[2] if ARGV[2]
      environment(name, options).create
    end
  
    def self.use
      name = ARGV[ARGV.index('use') + 1]
      options[:global] = true
      environment(name, options).use
    end
  
    def self.reload
      ruby = File.readlink("#{Dir.home}/.mineshaft/bin/ruby").split('/')
      bin_dir = ruby.shift(ruby.length - 1).join('/')
      FileUtils.rm Dir.glob("#{Dir.home}/.mineshaft/bin/*")
  
      Dir["#{bin_dir}/*"].each do |binary_absolute|
        binary = binary_absolute.split('/').last
        FileUtils.ln_s binary_absolute, "#{Dir.home}/.mineshaft/bin/#{binary}"
      end
  
      puts '💫 Binaries successfully reloaded!'
    end
  
    def self.list
      versions = YAML.load_file(File.join(File.dirname(File.expand_path(__FILE__)), '../../versions/versions.yaml'))
      last_ten = []
  
      Hash[versions.sort_by { |_k, v| -v }[versions.length - 10..versions.length]].each_key do |version|
        last_ten.push(version)
      end
  
      puts 'Latest 10 Ruby versions available for download'
      puts '----------------------------------------------'
      last_ten.reverse.each { |ver| puts ver }
    end

    def self.version
      @logger.log "mineshaft v#{Mineshaft::Version.current}"
    end
  end
end
