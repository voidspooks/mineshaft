# mineshaft
#
# author:: Cameron Testerman
# email:: cameronbtesterman@gmail.com
# created:: 2017-10-23 7:01PM
#
# Copyright (c) 2017 Cameron Testerman

module Mineshaft
  module Shell
    def shell(dir, cmd)
      puts "Running #{cmd}"
      %x{ cd #{dir} && #{cmd} }
    end
  end
end
