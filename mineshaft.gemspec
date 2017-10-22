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
                                     Dir["versions/versions.yaml"]
  spec.homepage                    = "https://github.com/camerontesterman/mineshaft"
  spec.license                     = "MIT"

  spec.executables                 << "mineshaft"

  spec.add_runtime_dependency "rbzip2", ["= 0.3.0"]
end
