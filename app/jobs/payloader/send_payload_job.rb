module Payloader
  class SendPayloadJob < ActiveJob::Base
    queue_as :worker

    def perform(event_id)
      Payloader::Event.find(event_id)
    end
  end
end
