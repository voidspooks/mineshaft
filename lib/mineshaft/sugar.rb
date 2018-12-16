# mineshaft
#
# author:: Cameron Testerman
# email:: cameronbtesterman@gmail.com
# created:: 2018-12-15 10:20PM
#
# Copyright (c) 2017-2018 Cameron Testerman

module Mineshaft
  module Sugar
    def self.environment(name, options)
      Mineshaft::Environment.new(name, options)
    end

    def self.list_globals
      Mineshaft.list_globals
    end

    def self.reload_binaries
      Mineshaft.reload_binaries
    end
  end
end