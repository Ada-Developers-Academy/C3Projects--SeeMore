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

  factory :subscription do
    user_id 12
    followee_id 100
  end
end
