FactoryGirl.define do  factory :tweet_post do
    post_id 1
posted_at "2015-08-09 12:51:21"
text "MyText"
media_url "MyString"
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
    user_ids [1, 2]
  end

  factory :tweet do
    username "Ada"
    provider_id "1357"
    user_ids [1, 2]
  end
end
