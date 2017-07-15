require 'active_support/configurable'

module Payloader
  class Config
    include ActiveSupport::Configurable
    config_accessor :retry_limit, :retry_interval

    configure do |config|
      config.retry_limit = 5
      config.retry_interval = 180
    end
  end
end