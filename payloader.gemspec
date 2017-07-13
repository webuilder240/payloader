$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "payloader/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "payloader"
  s.version     = Payloader::VERSION
  s.authors     = ["Nishio Takuya"]
  s.email       = ["littlecub240@gmail.com"]
  s.homepage    = "TODO"
  s.summary     = "TODO: Summary of Payloader."
  s.description = "TODO: Description of Payloader."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 4.2.4"

  s.add_development_dependency "sqlite3"
end
