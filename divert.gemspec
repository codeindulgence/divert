$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "divert/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "divert"
  s.version     = Divert::VERSION
  s.authors     = ["Nick Butler"]
  s.email       = ["nick@hhd.com"]
  s.summary     = "Easily handle 404s and redirects with your rails app."
  s.description = "Adds a route helper and controller action to catch 404 pages. 404s are stored in the database where a redirect can be set up."

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 3.2.11"
  # s.add_dependency "jquery-rails"

  s.add_development_dependency "sqlite3"
end
