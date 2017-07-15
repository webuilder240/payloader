module Payloader
  class Event < ActiveRecord::Base
    include Payloader::GenerateUuid
    before_create :set_url

    belongs_to :site
    belongs_to :site_url
    validates :event_type, presence: true, length: {maximum: 255}
    validates :body, presence: true

    def send_payload
      Payloader::SendPayloadJob.perform_later(id)
    end

    def retry

    end

    private

    def set_url
      self.post_url = site_url.url
    end
  end
end
