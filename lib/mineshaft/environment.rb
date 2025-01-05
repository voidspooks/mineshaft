# frozen_string_literal: true

# author:: Cameron Testerman
# email:: cameronbtesterman@gmail.com
# created:: 2017-04-14 1:19PM


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

require 'fileutils'
require 'yaml'
require 'mineshaft/commands'

module Mineshaft
  class Environment
    attr_reader :dir

    def initialize(dir, options)
      @dir = options[:global] ? File.join(Dir.home, ".mineshaft", dir) : dir
      @options = options
      @version = @options[:version] ? @options[:version] : Mineshaft::Constants::RUBY_VERSION_STABLE
      @logger = Mineshaft::Logger
    end

    def create
      FileUtils::mkdir_p(@dir)
      install_ruby
      if @options[:global]
        set_new_global
        `gem install mineshaft`
        Mineshaft.reload
      else
        create_activate_script
      end
    end

    def use
      set_new_global
      puts "Now using the environment at: #@dir"
    end

    private

    def install_ruby
      Mineshaft::Installer.new do |config|
        config.url = Mineshaft::RubyVersions.urlize(@version)
        config.directory = @dir
        config.version = @version
        config.options = @options
        config.global = @options[:global]
      end.run
    end

    def create_activate_script
      open("#{@dir}/bin/activate.sh", 'w') do |f|
        f << "#!/bin/bash\n"
        f << "#\n"
        f << "# activate.sh\n"
        f << "\n"
        f << "OLDPS1=$PS1\n"
        f << "ENV=#{@dir}\n"
        f << 'PS1="($ENV)${OLDPS1}"'
        f << "\n"
        f << "\n"
        f << "OLDPATH=$PATH\n"
        f << "PATH=#{File.expand_path("#{@dir}/bin")}:$OLDPATH\n"
        f << "\n"
        f << "deactivate() {\n"
        f << "  PS1=$OLDPS1\n"
        f << "  PATH=$OLDPATH\n"
        f << "}\n\n"
      end
    end

    def set_new_global
      if Dir["#{@dir}/bin/*"].length == 0
        puts "#@dir is not a valid environment - exiting" 
        exit
      end

      FileUtils.mkdir_p "#{Dir.home}/.mineshaft/bin"
      FileUtils.rm Dir.glob("#{Dir.home}/.mineshaft/bin/*")

      ["#{Dir.home}/.bash_profile", "#{Dir.home}/.zshrc"]
        .each { |profile| modify_shell_profile(profile) }

      Dir["#{@dir}/bin/*"].each do |binary_absolute|
        binary = binary_absolute.split("/").last
        FileUtils::ln_s binary_absolute, "#{Dir.home}/.mineshaft/bin/#{binary}" 
      end
    end

    def modify_shell_profile(profile)
      @logger.log "Checking if #{profile} exists.", level: :debug
      return unless File.exist?(profile)

      @logger.log "Profile exists!", level: :debug
      mineshaft_path_not_set = File.readlines(profile).grep(/mineshaft/).length == 0

      @logger.log "mineshaft_path_not_set: #{mineshaft_path_not_set}", level: :debug
      open(profile, 'a') { |f| f.puts("PATH=#{Dir.home}/.mineshaft/bin:$PATH") } if mineshaft_path_not_set

      @logger.log "Profile modified!", level: :debug
    end
  end
end
