FactoryGirl.define do
  factory :feed do
    name "Awesome name"
    avatar "http://website.com"
    platform "instagram"
    platform_feed_id 1
  end

  factory :user_vimeo, class: Feed do
    id 741273
    name "Riley Blakeway"
    avatar nil
    platform "Vimeo"
    platform_feed_id 741273
  end

  factory :invalid_vimeo_feed, class: Feed do
    name "I like videos"
    avatar nil
    platform "Vimeo"
    platform_feed_id 2
  end

end
