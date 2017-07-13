require 'rails_helper'

module Payloader
  RSpec.describe Site, type: :model do

    let(:payloader_site) {
      FactoryGirl.create(:payloader_site)
    }

    subject { payloader_site }
    it {should respond_to(:signature)}
    it {should respond_to(:uuid)}
    it {should respond_to(:name)}

    it 'created at generate signature' do
      expect(payloader_site.signature.present?).to eq true
    end

    it 'created at generate uuid' do
      expect(payloader_site.uuid.present?).to eq true
    end

  end
end
