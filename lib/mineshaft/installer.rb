# frozen_string_literal: true

# author:: Cameron Testerman
# email:: cameronbtesterman@gmail.com
# created:: 2017-04-14 1:19PM

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

require 'fileutils'
require 'net/http'
require 'rubygems/package'
require 'zlib'
require 'mineshaft/shell'

module Mineshaft
  class Installer
    attr_accessor :url, :directory, :version

    include Mineshaft::Shell

    def initialize
      @ruby_archive = 'ruby.tar.gz'
      @logger = Mineshaft::Logger
      yield self
    end

    def run
      download; unzip; build
    end

    private

    def find_slash_indices
      slash_array = []
      url = @url.split('')
      i = 0

      url.each do |l|
        break if slash_array.length == 3

        slash_array.push(i) if l == '/'
        i += 1
      end

      @slash_array = slash_array
    end

    def split_url
      find_slash_indices
      beg = @slash_array[1] + 1
      fin = @slash_array[2] - 1
      site = @url[beg..fin]
      fin += 1
      tar = @url[fin..url.length]

      yield site, tar
    end

    def download
      @logger.log "🪄  Downloading Ruby #{@version}..."
      split_url do |site, file|
        Net::HTTP.start(site) do |http|
          response = http.get(file)
          open("#{@directory}/#{@ruby_archive}", 'w') do |f|
            f.write(response.body)
          end
        end
      end
      @logger.log "🎉 Ruby #{@version} successfully downloaded!"
    end

    def unzip
      FileUtils.mkdir_p("#{@directory}/ruby-#{@version}")
      tar_extract = Gem::Package::TarReader.new(Zlib::GzipReader.open("#{@directory}/#{@ruby_archive}"))
      tar_extract.rewind
      @logger.log '🗃️  Unzipping archive...'
      tar_extract.each do |entry|
        if entry.full_name.split('').last == '/'
          @logger.log "extracted dir: #{@diretory}}/#{entry.full_name}", level: :debug
          FileUtils.mkdir_p("#{@directory}/#{entry.full_name}")
        elsif entry.file?
          @logger.log "extracted file: #{@directory}/#{entry.full_name}", level: :debug
          File.open("#{@directory}/#{entry.full_name}", 'w') { |file| file.write(entry.read) }
        end
      end
      @logger.log '🥳 Archive successfully unzipped!'
      tar_extract.close
    end

    def configure_options
      config = @global ? "./configure --prefix #{@directory}" : "./configure --prefix #{File.expand_path(@directory)}"
      config << ' > /dev/null 2>&1' unless @logger.verbose
      config << " --with-openssl-dir=#{OPTIONS.get(:openssl_dir)}" unless OPTIONS.get(:no_openssl_dir)
      @logger.log "Configuring Ruby with: #{config}", level: :debug
      config
    end

    def build
      @logger.log '🏗️  Building Ruby... (this will take some time)'
      @logger.log "Directory is #{@directory}", level: :debug
      @logger.log OPTIONS.get(:openssl_dir), level: :debug
      directory = "#{@directory}/ruby-#{@version}"

      commands = if @logger.verbose
                   [
                     'chmod +x configure tool/ifchange',
                     configure_options,
                     'make',
                     'make install'
                   ]
                 else
                   [
                     'chmod +x configure tool/ifchange',
                     configure_options,
                     'make > /dev/null 2>&1',
                     'make install > /dev/null 2>&1'
                   ]
                 end

      commands.each { |command| shell(directory:, commands: command) }
      @logger.log '✨ Ruby environment was successfully built!'
    end
  end
end
