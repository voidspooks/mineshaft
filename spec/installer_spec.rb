# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Mineshaft::Installer do
  describe '#run' do
    context 'with valid configuration' do
      let(:latest_stable) { Mineshaft::RubyVersions.latest_stable }
      let(:dir) { 'test_dir' }
      let(:options) do
        {
          openssl_dir: '/usr/local/opt/openssl',
          version: latest_stable,
          global: false
        }
      end

      before do
        FileUtils.mkdir_p(dir)
        Mineshaft::Installer.new do |config|
          config.url       = Mineshaft::RubyVersions.urlize(latest_stable)
          config.directory = dir
          config.version   = latest_stable
          config.options   = options
          config.global    = options[:global]
        end.run
      end

      after { FileUtils.rm_rf(dir) }

      it { expect(File).to exist("#{dir}/bin/ruby") }
    end
  end
end
