#!/usr/bin/ruby

require "environment"
require "install"

environment = RubyVenv::Environment.new(ARGV[0])
environment.create

ruby = RubyVenv::Install.new
ruby.download(ARGV[1])
ruby.build
