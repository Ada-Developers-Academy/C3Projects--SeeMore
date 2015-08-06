FactoryGirl.define do
  factory :user do
    provider 'instagram'
    uid 'e@mail.com'
    name 'Zynthia'
  end
  
  factory :followee do
    handle "handled"
    source "instagram"
  end
end
