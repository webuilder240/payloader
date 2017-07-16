module Payloader
  class Event < ActiveRecord::Base
    include Payloader::GenerateUuid
    before_create :set_url

    belongs_to :site
    belongs_to :site_url
    validates :event_type, presence: true, length: {maximum: 255}
    validates :body, presence: true

    def send_payload
      self.first_run_at = Time.now
      self.save
      Payloader::SendPayloadJob.perform_later(id)
    end

    def retry!
      self.retry_count +=1
      self.next_run_at = run_time
      save
      Payloader::SendPayloadJob.set(wait: next_run_at).perform_later(id)
    end

    def success!
      update(
        next_run_at: nil
      )
    end

    def failed!
      if limit_over?
        dead!
      else
        retry!
      end
    end

    def dead!
      update(
        next_run_at: nil,
        failed_at: Time.now
      )
    end

    def success?
      !failed? && !dead?
    end

    def failed?
      next_run_at.present? && failed_at.nil?
    end

    def dead?
      failed_at.present? && next_run_at.nil?
    end

    def run_time
      if limit_over?
        0.seconds
      else
        (retry_count * Payloader.config.retry_interval).seconds
      end
    end

    private

    def limit_over?
      retry_count >= Payloader.config.retry_limit
    end

    def set_url
      self.post_url = site_url.url
    end

  end
end
