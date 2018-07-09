# mineshaft
#
# author:: Cameron Testerman
# email:: cameronbtesterman@gmail.com
# created:: 2017-10-26 8:46PM
#
# Copyright (c) 2017-2018 Cameron Testerman

require 'erb'

module Mineshaft
  class ActivateTemplate
    attr_reader :result, :ENVDIR

    def initialize(dir, template_file)
      @dir = dir
      @template_file = read(template_file)
      $ENVDIR = dir
    end

    def create
      script_path = File.join(@dir, "bin/activate.sh")

      if File.exist?(script_path)
        File.truncate(script_path, 0)
        mode = 'w'
      end

      mode ||= 'a'

      @template_file.each do |line|
        File.open(script_path, mode) do |file|
          file.write(render(line))
        end
      end

      File.chmod(0755, script_path)
    end

    private

    def render(line)
      ERB.new(line).result
    end

    def read(file)
      File.open(file).readlines
    end
  end
end
