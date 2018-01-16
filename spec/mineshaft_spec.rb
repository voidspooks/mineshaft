require 'spec_helper'

describe Mineshaft do
  it 'create env dir' do
    options = [
      { 
        version: '2.5.0', 
      },
      {
        version: '2.4.3'
      }
    ]

    env = Mineshaft::Environment.new("test", options).create
    expect(File.exist?("test")).to eq true
    Dir.delete("test")
  end
end
