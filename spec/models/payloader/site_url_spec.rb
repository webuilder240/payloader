require 'rails_helper'

module Payloader
  RSpec.describe SiteUrl, type: :model do
    let(:payloader_site) {
      FactoryGirl.create(:payloader_site)
    }

    let(:payloader_site_url) {
      FactoryGirl.create(:payloader_site_url, site_id: payloader_site.id)
    }

    subject { payloader_site_url }
    it {should respond_to(:uuid)}
    it {should respond_to(:url)}

    it 'created at generate uuid' do
      expect(payloader_site.uuid.present?).to eq true
    end
  end
end
