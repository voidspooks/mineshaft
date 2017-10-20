require_relative "lib/mineshaft/version"

Gem::Specification.new do |spec|
  spec.name                        = "mineshaft"
  spec.version                     = Mineshaft::VERSION[:number]
  spec.date                        = "2017-10-20"
  spec.summary                     = "Ruby virtual environment manager"
  spec.authors                     = [ "Cameron Testerman" ]
  spec.email                       = "cameronbtesterman@gmail.com"
  spec.files                       = Dir["lib/mineshaft/*.rb"] +
                                     Dir["lib/*.rb"] +
                                     Dir["versions/versions.json"]
  spec.homepage                    = "https://github.com/camerontesterman/mineshaft"
  spec.license                     = "MIT"

  spec.executables                 << "ruby-venv"

  spec.add_development_dependency  "rspec"
  spec.add_development_dependency  "json"
  spec.add_development_dependency  "optparse"
end
