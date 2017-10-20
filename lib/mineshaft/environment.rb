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

    def initialize(dir)
      @dir= dir
    end

    def create
      FileUtils::mkdir_p(@dir)
    end
  end
end