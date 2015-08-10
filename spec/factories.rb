FactoryGirl.define do  factory :instagram_post do
    
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
