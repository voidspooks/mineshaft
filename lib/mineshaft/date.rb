# mineshaft
#
# author:: Cameron Testerman
# email:: cameronbtesterman@gmail.com
#
# Copyright (c) 2017-2018 Cameron Testerman

module Mineshaft
  module Date
    def self.prepend_zero(number)
      "%02d" % number
    end
  end
end
