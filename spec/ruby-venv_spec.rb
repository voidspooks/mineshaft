require 'spec_helper'

describe RubyVenv do
  it 'create env dir' do
    env = RubyVenv::Environment.new("test")
    env.create
    expect(File.exist?("test")).to eq true
    Dir.delete("test")
  end
end
