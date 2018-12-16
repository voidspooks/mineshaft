# mineshaft
#
# author:: Cameron Testerman
# email:: cameronbtesterman@gmail.com
# created:: 2018-12-15 10:20PM
#
# Copyright (c) 2017-2018 Cameron Testerman

module Mineshaft
  def self.env
    rubies = Dir["#{Mineshaft::Constants::GLOBAL_DIR}/*"]
    rubies.delete Mineshaft::Constants::GLOBAL_BIN

    puts "Globally installed Ruby versions"
    puts "--------------------------------"
    rubies.each { |ruby| puts ruby.split("/").last }
  end

  def self.environment(name, options)
    Mineshaft::Environment.new(name, options)
  end

  def self.new(name, options)
    environment(name, options).create
  end

  def self.use(name, options)
    environment(name, options).use
  end

  def self.reload
    Mineshaft.reload_binaries
  end
end