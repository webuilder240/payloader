require 'sidekiq/api'

module Payloader
  class Event < ActiveRecord::Base
    include Payloader::GenerateUuid

    validates :url, presence: true
    validates :signature, presence: true
    validates :http_method, presence: true, inclusion: { in: %w(post put patch delete) }
    validates :body, presence: true

    def send_payload
      self.first_run_at = Time.now
      save!
      Payloader::SendPayloadJobWorker.perform_async(id)
    end

    def retry!
      self.retry_count +=1
      self.next_run_at = run_time
      queue_destroy!
      job = Payloader::SendPayloadJobWorker.perform_at(next_run_at, id)
      self.job_id = job
      save!
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

    def enqueued?
      Sidekiq::Queue.new.find_job(job_id).present? if job_id.present?
      false
    end

    private


    def queue_destroy!
      if job_id.present?
        Sidekiq::Queue.new.find_job(job_id).delete
      end
    end

    def limit_over?
      retry_count >= Payloader.config.retry_limit
    end
  end
end
