module Payloader
  class SendPayloadJob < ActiveJob::Base
    queue_as :worker

    def perform(event_id)
      begin
        event = Payloader::Event.find(event_id)
        client = Payloader::Client.new()
        response = client.send(event.http_method.downcase, event.site_url, JSON.parse(event.body))
        if (400..599).include?(response.status)
          event.failed!
        else
          event.success!
        end
      rescue Faraday::Error::TimeoutError
        event.failed!
      rescue ActiveRecord::RecordNotFound => e
        Rails.logger.error(e.message)
        Rails.logger.error(e.backtrace.join("\n"))
      end
    end

  end
end
