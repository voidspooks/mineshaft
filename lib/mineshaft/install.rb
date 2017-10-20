# mineshaft
#
# author:: Cameron Testerman
# email:: cameronbtesterman@gmail.com
# created:: 2017-04-14 1:19PM
#
# Copyright (c) 2017 Cameron Testerman

require 'json'
require 'net/http'

module Mineshaft
  class Install
    def get_latest_stable
      "2.3.0"
    end

    def find_slash_indices(url)
      slash_array = []
      url = url.split("")
      i = 0

      url.each do |l|
        break if slash_array.length == 3
        slash_array.push(i) if l == "/"
        i += 1
      end

      @slash_array = slash_array
    end

    def split_url(url)
      find_slash_indices(url)
      beg = @slash_array[1] + 1
      fin = @slash_array[2] - 1
      site = url[beg..fin]
      fin += 1
      tar = url[fin..url.length]

      yield site, tar
    end

    def download(url, download_dir)
      split_url(url) do |site, file|
        Net::HTTP.start(site) do |http|
          response = http.get(file)
          open("#{download_dir}/ruby.tar.bz2", "w") do |f|
            f.write(response.body)
          end
        end
      end
    end

    def unzip
    end

    def build(prefix)
      %x(./configure --prefix #{prefix}; make; sudo make install)
    end
  end
end
