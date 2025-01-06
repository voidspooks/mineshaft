# frozen_string_literal: true

# author:: Cameron Testerman
# email:: cameronbtesterman@gmail.com
# created:: 2025-01-05 7:49PM

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
  module Downloader
    def self.download(version:, destination:)
      LOGGER.log "🪄  Downloading Ruby #{version}..."

      site = Mineshaft::RubyVersions.site
      zipfile = Mineshaft::RubyVersions.zipfile(version)

      download_file(site, zipfile, destination) do |response|
        write_file(destination, response)
      end

      LOGGER.log "🎉 Ruby #{version} successfully downloaded!"
    end

    def self.write_file(destination, response)
      open(destination, 'w') do |f|
        f.write(response.body)
      end
    end

    def self.download_file(site, file, destination)
      Net::HTTP.start(site) do |http|
        response = http.get(file)
        yield response
      end
    end
  end
end
