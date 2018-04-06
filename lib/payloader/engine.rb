require 'sidekiq'
require "faraday"
require "faraday_middleware"
require "payloader/client"

module Payloader
  class Engine < ::Rails::Engine
    isolate_namespace Payloader
    config.generators do |g|
      g.test_framework :rspec, fixture: false
      g.fixture_replacement :factory_girl, dir: "spec/factories"
    end
  end
end
