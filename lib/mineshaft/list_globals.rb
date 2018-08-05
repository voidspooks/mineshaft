# mineshaft
#
# author:: Cameron Testerman
# email:: cameronbtesterman@gmail.com
# created:: 2018-08-04 11:42PM
#
# Copyright (c) 2017-2018 Cameron Testerman

module Mineshaft
  def Mineshaft.list_globals
    rubies = Dir["#{Mineshaft::Constants::GLOBAL_DIR}/*"]
    rubies.delete Mineshaft::Constants::GLOBAL_BIN

    puts "Globally installed Ruby versions"
    puts "--------------------------------"
    rubies.each { |ruby| puts ruby.split("/").last }
  end
end