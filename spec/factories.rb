FactoryGirl.define do
  factory :user do
    provider 'instagram'
    uid 'e@mail.com'
    name 'Zynthia'

  factory :followee do
    handle "handled"
    source "instagram"
  end
end
