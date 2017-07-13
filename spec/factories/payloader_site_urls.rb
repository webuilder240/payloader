FactoryGirl.define do
  factory :payloader_site_url, class: 'Payloader::SiteUrl' do
    site_id 1
    uuid "MyString"
    url "MyString"
    livemode false
  end
end
