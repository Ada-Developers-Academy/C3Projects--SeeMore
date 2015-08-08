FactoryGirl.define do

  factory :post do
    username "MyString"
    posted_at "2015-08-07 16:59:22"
    content_id "MyString"
  end

  factory :twi_sub, class: Subscription do
    twitter_id "123456"
  end

  factory :ig_sub, class: Subscription do
    instagram_id "123456"
  end

  factory :user do
    uid "789"
    provider "Instagram"
  end

    # after(:build) {|user| user.subscriptions << [create(:ig_sub)] }
    # after(:build) {|user| user.subscriptions << [create(:twi_sub)] }
end
