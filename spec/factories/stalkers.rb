FactoryGirl.define do
  factory :stalker do
    sequence(:uid) { |n| "#{n}#{n}#{n}" }
    username { "User#{uid}" }
    provider "provider"
  end
end
