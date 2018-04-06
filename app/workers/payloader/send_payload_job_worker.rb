module Payloader
  class SendPayloadJobWorker
    include Sidekiq::Worker
    sidekiq_options queue: :event_worker

    def perform(event_id)
      begin
        event = Payloader::Event.find(event_id)
        client = Payloader::Client.new()
        response = client.send(event.http_method.downcase, event.url, JSON.parse(event.body))
        if (400..599).include?(response.status)
          event.failed!
        else
          event.success!
        end
      rescue Faraday::Error::TimeoutError
        event.failed!
      rescue ActiveRecord::RecordNotFound => ex
        Rails.logger.error(ex.message)
        Rails.logger.error(ex.backtrace.join("\n"))
      end
    end
  end
end
