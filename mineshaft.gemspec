require_relative "lib/mineshaft/version"
require_relative "lib/mineshaft/date"
require "date"

date  = DateTime.now
year  = date.year
month = date.month.to_s.length == 1 ? Mineshaft::Date.prepend_zero(date.month) : date.month
day   = date.day.to_s.length   == 1 ? Mineshaft::Date.prepend_zero(date.day)   : date.day

Gem::Specification.new do |spec|
  spec.name                        = "mineshaft"
  spec.version                     = Mineshaft::Version.current
  spec.date                        = "#{year}-#{month}-#{day}"
  spec.summary                     = "Ruby virtual environment manager"
  spec.authors                     = [ "Cameron Testerman" ]
  spec.email                       = "cameronbtesterman@gmail.com"
  spec.files                       = Dir["lib/mineshaft/*.rb"] +
                                     Dir["lib/*.rb"] +
                                     Dir["versions/versions.yaml"]
  spec.homepage                    = "https://gitlab.com/ctesterman/mineshaft"
  spec.license                     = "MIT"

  spec.executables                 << "ms"
  spec.add_development_dependency  'rspec', '~> 3.13'
end
