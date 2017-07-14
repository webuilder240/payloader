FactoryGirl.define do
  factory :payloader_event, class: 'Payloader::Event' do
    site_id 1
    uuid "MyString"
    event_type "MyString"
    body "MyText"
    retry_count 0
    first_run_at "2017-07-14 22:30:57"
    next_run_at "2017-07-14 22:30:57"
    failed_at "2017-07-14 22:30:57"
  end
end
