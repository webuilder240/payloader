module Payloader
  class Client

    def initialize
      Faraday::Connection.new() do |builder|
        builder.options[:open_timeout] = Payloader.config.request_timeout
        builder.options[:timeout] = Payloader.config.request_timeout
        builder.request :json
        builder.response :logger
        builder.adapter Faraday.default_adapter
      end
    end

  end
end