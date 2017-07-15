require 'rails_helper'

module Payloader
  RSpec.describe Event, type: :model do
    let(:payloader_site) {
      FactoryGirl.create(:payloader_site)
    }

    let(:payloader_site_url) {
      FactoryGirl.create(:payloader_site_url, site_id: payloader_site.id)
    }

    let(:event) {
      FactoryGirl.create(:payloader_event, site_id: payloader_site.id, site_url_id: payloader_site_url.id)
    }

    subject { event }
    it {should respond_to(:uuid)}
    it {should respond_to(:post_url)}

    it 'created at generate uuid' do
      expect(event.uuid.present?).to eq true
    end

    it 'created at retry_count' do
      expect(event.retry_count).to eq 0
    end

    it 'association site_url' do
      expect(event.site_url.id).to eq payloader_site_url.id
    end

    it 'set post_url site_url' do
      expect(event.post_url).to eq payloader_site_url.url
    end

    describe 'method' do
      describe 'send_payload' do
        it 'Queue Set Payloader::SendPayloadJob' do
          expect {
            event.send_payload
          }.to have_enqueued_job(Payloader::SendPayloadJob)
        end
      end

      describe 'failed? && failed!' do
        it '死んでいないJOBに対してはfalseを出力すること' do
          event.next_run_at = Time.now
          event.retry_count = 1
          event.save
          expect(event.dead?).to eq false
        end
        it 'retry_limitが5なので、JOBが死んだ状態になること' do
          event.retry_count = 5
          event.failed_at = Time.now
          event.save
          expect(event.dead?).to eq true
        end
        it 'faild!を発行するとJOBが死んだ状態になること' do
          event.retry_count = 5
          event.save
          event.dead!
          expect(event.dead?).to eq true
        end
      end

      describe 'run_time' do
        it 'retry_countが1でintervalが180なので、180秒後に設定されていること' do
          event.retry_count = 1
          expect(event.run_time).to eq 180
        end

        it 'retry_countが4でintervalが180なので、720秒後に設定されていること' do
          event.retry_count = 4
          expect(event.run_time).to eq 720
        end
        it 'retry_countが上限の場合、run_timeは0を返すこと' do
          event.retry_count = Payloader.config.retry_limit
          expect(event.run_time).to eq 0
        end
      end

    end
  end
end
