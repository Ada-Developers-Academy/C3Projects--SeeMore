FactoryGirl.define do  factory :instagram do
    
  end

  factory :user do
    email    "a@b.com"
    username "Ada"
    uid      "12345"
    provider "developer"
  end

  # factory :ig_user do
  #   email    "a@b.com"
  #   username "IGAda"
  #   uid      "12345"
  #   provider "instagram"
  # end
end
