FactoryGirl.define do
  factory :post do
    description "Awesome description"
    content "Some content"
    date_posted Date.parse("June 2014")
    feed_id 1
  end
end
