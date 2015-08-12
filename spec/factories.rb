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
    created_time "2015-08-06 15:07:59 -0700"
    tw_retweet_count 5
    tw_favorite_count 2
    tw_user_id_str "100"
    tw_user_id 1
  end


  factory :gram do
    tags "whorundaworld?"
    media_type "image"
    created_time "1435626415"
    link "https://instagram.com/p/4iMUbxCKwZ/"
    likes 16
    image_url "peeps.jpg"
    caption "whatevs"
    ig_id "12345678910111213141516"
    ig_username "Talking Rain"
    ig_user_pic "photo.jpg"
    ig_user_id "12345678"
    ig_user_fullname "Talking Rain Sparkling H20"
    user_id 1
  end

  factory :instagram_user do
    username "Talking Rain"
    profile_pic "photo.jpg"
    ig_user_id "12345678"
    fullname "Talking Rain Sparkling H20"
  end

end
