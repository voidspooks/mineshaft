# mineshaft
#
# author:: Cameron Testerman
# email:: cameronbtesterman@gmail.com
# created:: 2018-07-03 9:53PM
#
# Copyright (c) 2017-2018 Cameron Testerman

module Mineshaft
  def Mineshaft.reload_binaries
    ruby = File.readlink("#{Dir.home}/.mineshaft/bin/ruby").split('/')
    bin_dir = ruby.shift(ruby.length - 1).join("/")
    FileUtils.rm Dir.glob("#{Dir.home}/.mineshaft/bin/*")

    Dir["#{bin_dir}/*"].each do |binary_absolute|
      binary = binary_absolute.split("/").last
      FileUtils::ln_s binary_absolute, "#{Dir.home}/.mineshaft/bin/#{binary}" 
    end

    puts "Binaries successfully reloaded!"
  end
end