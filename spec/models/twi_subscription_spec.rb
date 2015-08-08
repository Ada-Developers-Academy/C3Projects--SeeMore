require 'rails_helper'

RSpec.describe TwiSubscription, type: :model do
  let(:twi_subscription) {
    TwiSubscription.new(twitter_id: "123465")
  }

  describe "model validations" do

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
      dup_sub = TwiSubscription.new(twitter_id: "123465")

      expect(dup_sub).to be_invalid
      expect(dup_sub.errors.keys).to include(:twitter_id)
    end
  end

  describe "model associations" do
    it "a Twitter subscription has and belongs to a user" do
      user = User.create(name: "user1", provider: "developer", uid: "uid1")
      twisub = TwiSubscription.create(twitter_id: "123465")
      user.twi_subscriptions << twisub

      expect(user.twi_subscriptions.first.twitter_id).to eq "123465"
      expect(twisub.users.first.name).to eq "user1"
    end
  end

  describe "model methods" do
    context "#find_twitter_id" do
      it "finds a twitter subscription according to twitter_id" do
        twi_subscription.save

        expect(TwiSubscription.find_twitter_id("123465")).to eq twi_subscription
      end

      it "returns an empty ActiveRecord object if twitter_id doesn't exist" do
        subscription = TwiSubscription.find_twitter_id("0")

        expect(subscription).to be_nil
        expect(TwiSubscription.count).to eq 0
      end
    end

    context "#find_or_create_subscription" do
      let(:twisub) { TwiSubscription.find_or_create_subscription("123465") }
      it "if subscription does not exist, it creates it" do
        twisub

        expect(TwiSubscription.count).to eq 1
        expect(TwiSubscription.first.twitter_id).to eq "123465"
      end

      it "returns created subscription" do
        expect(twisub).to eq TwiSubscription.first
      end

      it "if subscription does exist, it finds & returns it" do
        twi_subscription.save

        expect(twisub).to eq twi_subscription
      end
    end
  end
end
