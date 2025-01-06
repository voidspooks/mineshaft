# frozen_string_literal: true

# author:: Cameron Testerman
# email:: cameronbtesterman@gmail.com
# created:: 2025-01-05 9:29PM

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
  class Unzipper
    def initialize(directory)
      @directory = directory
      @version = OPTIONS.get(:version)
    end

    def unzip
      FileUtils.mkdir_p("#{@directory}/ruby-#{@version}")
      tar_extract = Gem::Package::TarReader.new(Zlib::GzipReader.open("#{@directory}/#{Mineshaft::Installer::RUBY_ARCHIVE}"))
      tar_extract.rewind
      LOGGER.log '🗃️  Unzipping archive...'
      tar_extract.each do |entry|
        if entry.full_name.split('').last == '/'
          LOGGER.log "extracted dir: #{@diretory}}/#{entry.full_name}", level: :debug
          FileUtils.mkdir_p("#{@directory}/#{entry.full_name}")
        elsif entry.file?
          LOGGER.log "extracted file: #{@directory}/#{entry.full_name}", level: :debug
          File.open("#{@directory}/#{entry.full_name}", 'w') { |file| file.write(entry.read) }
        end
      end
      LOGGER.log '🥳 Archive successfully unzipped!'
      tar_extract.close
    end
  end
end
