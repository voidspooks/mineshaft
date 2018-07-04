require 'spec_helper'

describe Mineshaft do
  it 'create env dir' do
    options = { 
      version: '2.5.1'
    }

    env = Mineshaft::Environment.new("test", options).create
    expect(File.exist?("test")).to eq true
    Dir.delete("test")
  end
end
