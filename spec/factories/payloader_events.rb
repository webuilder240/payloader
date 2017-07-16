FactoryGirl.define do
  factory :payloader_event, class: 'Payloader::Event' do
    site_id 1
    uuid "MyString"
    event_type "payment.success"
    body "MyText"
    retry_count 0
    first_run_at nil
    next_run_at nil
    failed_at nil
  end
end
