require 'spec_helper'

describe Mineshaft do
  it 'create env dir' do
    env = Mineshaft::Environment.new("test")
    env.create
    expect(File.exist?("test")).to eq true
    Dir.delete("test")
  end
end
