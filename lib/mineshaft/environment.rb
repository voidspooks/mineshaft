# mineshaft
#
# author:: Cameron Testerman
# email:: cameronbtesterman@gmail.com
# created:: 2017-04-14 1:19PM
#
# Copyright (c) 2017-2021 Cameron Testerman

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

    def build_version_url
      "https://cache.ruby-lang.org/pub/ruby/#{@version[0..2]}/ruby-#{@version}.tar.gz"
    end

    def install_ruby
      Mineshaft::Installer.new do |config|
        config.url = build_version_url
        config.directory = @dir
        config.version = @version
        config.options = @options
        config.global = @options[:global]
      end.run
    end

    def install_mineshaft
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
