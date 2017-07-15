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

    end
  end
end
