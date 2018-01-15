module Mineshaft
  module Date
    def self.prepend_zero(number)
      "%02d" % number
    end
  end
end
