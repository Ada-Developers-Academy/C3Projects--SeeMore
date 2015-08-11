FactoryGirl.define do
  factory :instagram_post do
    post_id "555555555"
    instagram_id 1
    created_at Time.now
    image_url "http://www.imagehere.com"
  end

  factory :tweet_post do
    post_id "444444444"
    posted_at  Time.now
    text "I am tweeting now."
    media_url "http://www.imagehere.com"
    tweet_id 1
  end

  factory :user do
    email    "a@b.com"
    username "Ada"
    uid      "12345"
    provider "developer"
  end

  factory :instagram do
    username "Ada"
    provider_id "1357"
    user_ids 1
  end

  factory :tweet do
    username "Ada"
    provider_id "1357"
    user_ids 1
  end
end
