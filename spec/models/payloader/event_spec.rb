require 'rails_helper'

module Payloader
  RSpec.describe Event, type: :model do

    let(:event) {
      FactoryGirl.create(:payloader_event)
    }

    subject { event }

    it {should respond_to(:http_method)}
    it {should respond_to(:uuid)}
    it {should respond_to(:signature)}

    it 'created at generate uuid' do
      expect(event.uuid.present?).to eq true
    end

    it 'created at retry_count' do
      expect(event.retry_count).to eq 0
    end

    describe 'method' do
      describe 'send_payload' do
        it 'Queue Set Payloader::SendPayloadJobWorker' do
          event.send_payload
          expect (Payloader::SendPayloadJobWorker).to have_enqueued_sidekiq_job('Payloader::SendPayloadJobWorker', true)
        end
      end

      describe 'retry!' do
        before { event.retry! }
        it 'Queue Set Payloader::SendPayloadJobWorker' do
          expect (Payloader::SendPayloadJobWorker).to have_enqueued_sidekiq_job('Payloader::SendPayloadJobWorker', true)
        end
        it '実行時にリトライ回数が増加していること' do
          expect(event.retry_count).to eq 1
        end
        it '次回実行時間が180秒後であること' do
          expect(event.next_run_at).to eq nil
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

        it 'faild!を発行すると次回実行予定が削除される' do
          event.dead!
          expect(event.next_run_at).to eq nil
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
