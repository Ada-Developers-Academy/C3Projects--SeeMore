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

      expect(user.subscriptions.first.instagram_id).to eq "215892539"
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

# Model Methods!
  describe "twitter methods" do
    context "#find_twitter_id" do
      it "finds subscription by twitter_id" do
        twisub.save

        expect(Subscription.find_twitter_id("123456")).to eq twisub
      end

      it "returns an empty ActiveRecord object if twitter_id doesn't exist" do
        subscription = Subscription.find_twitter_id("0")

        expect(subscription).to be_nil
        expect(Subscription.count).to eq 0
      end
    end

    context "#find_or_create_twi_subscription" do

      it "if subscription does not exist, it creates it" do
        Subscription.find_or_create_twi_subscription("123456")

        expect(Subscription.count).to eq 1
        expect(Subscription.first.twitter_id).to eq "123456"
      end

      it "if subscription does exist, it finds & returns it" do
        twisub.save

        expect(Subscription.find_or_create_twi_subscription("123456")).to eq twisub
      end
    end
  end

  describe "instagram methods" do
    context "#find_instagram_id" do
      it "finds subscription by instagram_id" do
        igsub.save

        expect(Subscription.find_instagram_id("215892539")).to eq igsub
      end

      it "returns an empty ActiveRecord object if instagram_id doesn't exist" do
        subscription = Subscription.find_instagram_id("0")

        expect(subscription).to be_nil
        expect(Subscription.count).to eq 0
      end
    end

    context "#find_or_create_ig_subscription" do

      it "if subscription does not exist, it creates it" do
        Subscription.find_or_create_ig_subscription("215892539")

        expect(Subscription.count).to eq 1
        expect(Subscription.first.instagram_id).to eq "215892539"
      end

      it "if subscription does exist, it finds & returns it" do
        igsub.save

        expect(Subscription.find_or_create_ig_subscription("215892539")).to eq igsub
      end
    end
  end
end
