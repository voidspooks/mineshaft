Gem::Specification.new do |spec|
  spec.name                        = "ruby-venv"
  spec.version                     = "0.1.0"
  spec.date                        = "2017-02-25"
  spec.summary                     = "ruby virtual environment manager"
  spec.authors                     = [ "Cameron Testerman" ]
  spec.email                       = "cameronbtesterman@gmail.com"
  spec.files                       = [ "lib/install.rb", "lib/environment.rb" ]
  spec.homepage                    = "https://rubygems.org/gems/ruby-venv"
  spec.license                     = "MIT"

  spec.executables                 << "ruby-venv"

  spec.add_development_dependency  "rspec"
  spec.add_development_dependency  "json"
end
