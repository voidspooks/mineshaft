# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Mineshaft do
  it 'should have a version number' do
    expect(Mineshaft::VERSION).not_to be nil
  end
end
