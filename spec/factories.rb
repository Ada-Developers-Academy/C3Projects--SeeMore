FactoryGirl.define do

  factory :user do
    provider 'instagram'
    uid 'e@mail.com'
    name 'Zynthia'
  end

  factory :followee do
    handle "handled"
    source "instagram"
    native_id "12345abcde"
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
