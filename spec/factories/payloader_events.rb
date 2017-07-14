FactoryGirl.define do
  factory :payloader_event, class: 'Payloader::Event' do
    site_id 1
    post_url "MyString"
    uuid "MyString"
    event_name "MyString"
    data "MyText"
    retry_count 1
    first_run_at "2017-07-14 22:30:57"
    next_run_at "2017-07-14 22:30:57"
    failed_at "2017-07-14 22:30:57"
  end
end
