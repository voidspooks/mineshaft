# mineshaft
#
# author:: Cameron Testerman
# email:: cameronbtesterman@gmail.com
# created:: 2018-07-03 9:16PM
#
# Copyright (c) 2017-2018 Cameron Testerman

require 'yaml'

module Mineshaft
  module List
    def List.display
      versions = YAML.load_file(File.join(File.dirname(File.expand_path(__FILE__)), '../../versions/versions.yaml'))
      last_ten = []

      Hash[versions.sort_by {|k, v| -v }[versions.length - 10..versions.length]].each do |version, url|
        last_ten.push(version)
      end

      last_ten.reverse.each {|ver| puts ver}
    end
  end
end