$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "divert/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "divert"
  s.version     = Divert::VERSION
  s.authors     = ["TODO: Your name"]
  s.email       = ["TODO: Your email"]
  s.homepage    = "TODO"
  s.summary     = "TODO: Summary of Divert."
  s.description = "TODO: Description of Divert."

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 3.2.11"
  # s.add_dependency "jquery-rails"

  s.add_development_dependency "sqlite3"
end
