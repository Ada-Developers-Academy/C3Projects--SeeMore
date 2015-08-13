FactoryGirl.define do

  factory :user do
    provider 'instagram'
    uid 'e@mail.com'
    name 'Zynthia'
  end

  factory :followee do
    handle "beyonce" 
    source "twitter" 
    avatar_url "http://pbs.twimg.com/profile_images/582395896593170432/pw_jGziR_normal.jpg"
    native_id 31239408
    last_post_id "369486010280706048"
  end

  factory :subscription do
    user_id 12
    followee_id 100
  end

  factory :post do
    followee_id         1
    source              "instagram"
    native_created_at   "2015-06-01"
    native_id           "www.instagram.com/blah"
    embed_html          "blah"
  end
end
