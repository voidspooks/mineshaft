require 'spec_helper'

describe Mineshaft::Installer do
  it "should install ruby" do
    versions = YAML.load_file(File.join(File.dirname(File.expand_path(__FILE__)), '../versions/versions.yaml'))
    options  = {
      openssl_dir: "/usr/local/opt/openssl",
      version: Mineshaft::Constants::RUBY_VERSION_STABLE,
      global: false
    } 

    Mineshaft::Installer.new do |config|
      config.url       = versions[Mineshaft::Constants::RUBY_VERSION_STABLE]
      config.directory = 'installer_test'
      config.version   = Mineshaft::Constants::RUBY_VERSION_STABLE
      config.options   = options
      config.global    = options[:global]
    end.run

    expect(File).to exist('installer_test/bin/ruby')
  end
end