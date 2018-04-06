FactoryGirl.define do
  factory :payloader_event, class: 'Payloader::Event' do
    url "MyString"
    http_method "post"
    uuid "MyString"
    body "MyText"
    signature "MyText"
    retry_count 0
    first_run_at nil
    next_run_at nil
    failed_at nil
  end
end
