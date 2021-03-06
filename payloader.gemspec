$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "payloader/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "payloader"
  s.version     = Payloader::VERSION
  s.authors     = ["Nishio Takuya"]
  s.email       = ["littlecub240@gmail.com"]
  s.homepage    = "https://github.com/webuilder240/payloader"
  s.summary     = "webhook send library"
  s.description = "webhook send library"
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["spec/**/*"]

  s.add_dependency "rails", "~> 4.2.4"
  s.add_dependency "sidekiq"
  s.add_dependency "faraday"
  s.add_dependency "faraday_middleware"
  s.add_development_dependency "sqlite3"
  s.add_development_dependency "rspec-rails"
  s.add_development_dependency "factory_girl_rails"
  s.add_development_dependency 'rspec-sidekiq'
end
