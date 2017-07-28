require 'active_support/configurable'

module Payloader
  class Config
    include ActiveSupport::Configurable
    config_accessor :retry_limit, :retry_interval, :request_timeout

    configure do |config|
      config.retry_limit = 5
      config.retry_interval = 180
      config.request_timeout = 5
    end
  end
end