# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Mineshaft::Environment do
  describe '#create' do
    context 'with valid configuration' do
      let(:options) do
        {
          openssl_dir: "/usr/local/opt/openssl",
          version: Mineshaft::RubyVersions.latest_stable,
          global: false
        }
      end
      let(:version) { Mineshaft::RubyVersions.latest_stable }
      let(:environment) { Mineshaft::Environment.new(version, options) }

      it 'can create virtual environment using the latest stable version of Ruby'  do
        environment.create
        expect(File.exist?("#{version}/bin/ruby")).to eq true
        FileUtils.rm_rf(version)
      end
    end
  end
end
