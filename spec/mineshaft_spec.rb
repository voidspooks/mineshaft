require 'spec_helper'
require 'fileutils'

describe Mineshaft do
  it 'create env dir' do
    options = { 
      version: '2.5.0', 
      openssl_dir: '/usr/local/opt/openssl' 
    }

    env = Mineshaft::Environment.new("test", options).create
    expect(File.exist?("test")).to eq true
    FileUtils.rm_r("test")
  end
end
