# mineshaft
#
# author:: Cameron Testerman
# email:: cameronbtesterman@gmail.com
# created:: 2017-10-26 8:46PM
#
# Copyright (c) 2017 Cameron Testerman
require 'erb'

module Mineshaft
  class ActivateTemplate
    attr_reader :result

    def initialize(template_file)
      @template_file = template_file
      read
    end

    def write_to_file(filepath)
      render_template
      File.open() # Write to the activate.sh file inside of the Ruby environment.
    end

    private

    def render_template
      @result = ERB.new(@template).result
    end

    def read
      @template = File.read(@template_file)
    end
  end
end
