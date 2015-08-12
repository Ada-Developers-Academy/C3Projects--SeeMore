FactoryGirl.define do

  factory :user do
    username "MyString"
    avatar_url "kitty.jpeg"
    uid "34432"
    provider "instagram"
  end

  factory :tw_user do
    tw_user_id_str "100"
    user_name "Beyonce"
    profile_image_url "http://fakeurl.org/beyonce.jpg"
    screen_name "beyonce"
  end

  factory :tweet do
    tw_id_str "500"
    tw_text "Don't worry, Be Yonce"
    tw_created_at "2015-08-06 15:07:59 -0700"
    tw_retweet_count 5
    tw_favorite_count 2
    tw_user_id_str "100"
    tw_user_id 1
  end
end
