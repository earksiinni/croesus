$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "croesus/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "croesus"
  s.version     = Croesus::VERSION
  s.authors     = ["Ersin Akinci"]
  s.email       = ["ersin@twomaestros.com"]
  s.homepage    = "https://github.com/twomaestros/croesus"
  s.summary     = "Lightweight token-based auth for Rails"
  s.description = "Devise for token-based authentication and authorization in Rails apps."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]

  s.add_dependency "rails", "~> 4.2.4"
  s.add_dependency "virtus"

  s.add_development_dependency "pg"
  s.add_development_dependency "rspec-rails"
  s.add_development_dependency "capybara"
  s.add_development_dependency "factory_girl_rails"
  s.add_development_dependency "byebug"
end
