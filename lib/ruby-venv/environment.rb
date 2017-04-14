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
