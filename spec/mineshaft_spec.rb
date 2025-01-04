require 'spec_helper'

describe Mineshaft do
  [
    '2.5.1',
    '2.4.3',
    '2.3.7'
  ].each do |version|
    it "can create Ruby version #{version} virtual environment"  do
      options = {
        openssl_dir: "/usr/local/opt/openssl",
        version: Mineshaft::Constants::RUBY_VERSION_STABLE,
        global: false
      }

      env = Mineshaft::Environment.new(version, options).create
      expect(File.exit?("test/bin/ruby")).to eq true
      Dir.delete(version)
    end
  end
end
