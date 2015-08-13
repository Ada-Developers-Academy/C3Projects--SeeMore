require 'rails_helper'

RSpec.describe Subscription, type: :model do
  let(:twisub) { build(:twi_sub) }
  let(:igsub)  { build(:ig_sub) }
  let(:user)   { build(:user) }

  describe "model associations" do
    it "a Twitter subscription has and belongs to a user" do
      user.save
      twisub.save
      user.subscriptions << twisub

      expect(user.subscriptions.first.twitter_id).to eq "123456"
      expect(twisub.users.first.uid).to eq "789"
    end

    it "a Instagram subscription has and belongs to a user" do
      user.save
      igsub.save
      user.subscriptions << igsub

      expect(user.subscriptions.first.instagram_id).to eq "123456"
      expect(igsub.users.first.uid).to eq "789"
    end

    it "has many posts" do
      igsub.save
      5.times do
        create(:post)
      end

      expect(igsub.posts.count).to eq 5
    end
  end

  describe "model validations" do

    it "requires an twitter id OR an instagram id" do
      expect(twisub).to be_valid
    end

    it "requires an twitter id OR an instagram id" do
      expect(igsub).to be_valid
    end

    it "won't create a subscription without an id" do
      nilsub = build(:nil_sub)

      expect(nilsub).to be_invalid
      expect(nilsub.errors.messages).to include(:ids)
    end

    it "won't create a subscription with both ids" do
      dupsub = build(:dup_sub)

      expect(dupsub).to be_invalid
      expect(dupsub.errors.messages).to include(:ids)
    end
  end
  # describe "model methods" do
  #   context "#find_twitter_id" do
  #     it "finds a twitter subscription according to twitter_id" do
  #       twi_subscription.save
  #
  #       expect(TwiSubscription.find_twitter_id("123465")).to eq twi_subscription
  #     end
  #
  #     it "returns an empty ActiveRecord object if twitter_id doesn't exist" do
  #       subscription = TwiSubscription.find_twitter_id("0")
  #
  #       expect(subscription).to be_nil
  #       expect(TwiSubscription.count).to eq 0
  #     end
  #   end
  #
  #   context "#find_or_create_subscription" do
  #     let(:twisub) { TwiSubscription.find_or_create_subscription("123465") }
  #     it "if subscription does not exist, it creates it" do
  #       twisub
  #
  #       expect(TwiSubscription.count).to eq 1
  #       expect(TwiSubscription.first.twitter_id).to eq "123465"
  #     end
  #
  #     it "returns created subscription" do
  #       expect(twisub).to eq TwiSubscription.first
  #     end
  #
  #     it "if subscription does exist, it finds & returns it" do
  #       twi_subscription.save
  #
  #       expect(twisub).to eq twi_subscription
  #     end
  #   end
  # end
end
