# mineshaft
#
# author:: Cameron Testerman
# email:: cameronbtesterman@gmail.com
#
# © 2017 Cameron Testerman

module Mineshaft
  module Date
    def self.prepend_zero(number)
      "%02d" % number
    end
  end
end
