# ruby-venv
#
# author:: Cameron Testerman
# email:: cameronbtesterman@gmail.com
# created:: 2017-04-14 1:19PM
#
# Copyright (c) 2017 Cameron Testerman

require 'fileutils'

module RubyVenv
  class Environment
    attr_reader :name

    def initialize(name)
      @name = name
    end

    def create
      FileUtils::mkdir_p(@name)
    end
  end
end
