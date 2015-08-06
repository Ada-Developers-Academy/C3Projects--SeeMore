require 'rails_helper'

RSpec.describe TwiSubscription, type: :model do
  describe "model validations" do
    let(:twi_subscription) {
      TwiSubscription.new(twitter_id: "@beast")
      }

    it "requires an twitter id" do

      expect(twi_subscription).to be_valid
    end

    it "won't create a subscription without an id" do
      invalid_sub = TwiSubscription.new

      expect(invalid_sub).to be_invalid
      expect(invalid_sub.errors.keys).to include(:twitter_id)
    end

    it "wont create a duplicate subscription" do
      twi_subscription.save
      dup_sub = TwiSubscription.new(twitter_id: "@beast")

      expect(dup_sub).to be_invalid
      expect(dup_sub.errors.keys).to include(:twitter_id)
    end
  end

  describe "model associations" do
    it "a Twitter subscription has and belongs to a user" do
      user = User.create(name: "user1", provider: "developer", uid: "uid1")
      twisub = TwiSubscription.create(twitter_id: "@beast")
      user.twi_subscriptions << twisub

      expect(user.twi_subscriptions.first.twitter_id).to eq "@beast"
      expect(twisub.users.first.name).to eq "user1"
    end
  end

end
