# frozen_string_literal: true

# author:: Cameron Testerman
# email:: cameronbtesterman@gmail.com
# created:: 2025-01-05 5:09PM

# Copyright (c) 2017 Cameron Testerman
#
# Permission is hereby granted, free of charge, to any person obtaining a copy of this software
# and associated documentation files (the “Software”), to deal in the Software without
# restriction, including without limitation the rights to use, copy, modify, merge, publish,
# distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the
# Software is furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all copies or
# substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED “AS IS”, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
# THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR
# OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
# ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
# OTHER DEALINGS IN THE SOFTWARE.

module Mineshaft
  class Options
    attr_reader :options, :help

    def initialize
      @options = {
        openssl_dir: '/opt/homebrew/opt/openssl',
        version: Mineshaft::RubyVersions.latest_stable,
        global: false,
        verbose: false
      }
      @parser = parser
    end

    def parse!      
      @parser.parse!
    end

    def get(key)
      @options[key]
    end

    def set(key, value)
      @options[key] = value
    end

    private

    def parser
      OptionParser.new do |opts|
        opts.banner = 'Usage: ms [command] [options]'
        opts.separator ''
        opts.separator 'Commands'
        opts.separator '    env                              shows a list of all installed global Rubies, with the current one in use highlighted'
        opts.separator '    install                          installs a new global Ruby'
        opts.separator '    list                             lists the ten latest versions of Ruby available to install'
        opts.separator '    new                              creates new environment'
        opts.separator '    reload                           reloads binaries using the current global Ruby version'
        opts.separator '    use                              selects an installed global Ruby environment to use'
        opts.separator '    version                          displays the current version of mineshaft'
        opts.separator ''
        opts.separator 'Options'
      
        opts.on('-v', '--verbose', 'provides more output from mineshaft, helpful in debugging') do
          LOGGER.verbose = true
        end
      
        opts.on('-o', '--with-openssl-dir DIR', 'specify the directory where OpenSSL is installed') do |openssl_dir|
          @options[:openssl_dir] = openssl_dir
        end
      
        opts.on('-n', '--no-openssl-dir',
                'do not set the OpenSSL directory - otherwise this defaults to /usr/local/opt/openssl') do |_no_openssl|
          @options[:no_openssl_dir] = true
        end

        @options[:help] = opts.help
      end
    end
  end
end
