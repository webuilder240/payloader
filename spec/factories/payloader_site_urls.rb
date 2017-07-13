FactoryGirl.define do
  factory :payloader_site_url, class: 'Payloader::SiteUrl' do
    site_id 1
    uuid ""
    url "http://localhost"
    livemode false
  end
end
