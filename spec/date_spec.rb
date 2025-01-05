require 'spec_helper'
require 'mineshaft/date'

RSpec.describe Mineshaft::Date do
  it "should prepend zero to number" do
    expect(Mineshaft::Date.prepend_zero(1)).to eql("01")
  end
end
