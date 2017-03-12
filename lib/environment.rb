module RubyVenv
  class Environment
    attr_reader :name

    def initialize(name)
      @name = name
    end

    def create
      %x{ mkdir #@name }
    end
  end
end
