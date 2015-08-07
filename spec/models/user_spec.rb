require 'rails_helper'

RSpec.describe User, type: :model do

  let(:user) {
    User.new(
      email: "a@b.com",
      name: "Ada",
      uid: "12354",
      provider: "twitter"
      )
    }

  describe "validations" do
    it "is valid" do
      expect(user).to be_valid
    end

    it "requires a uid" do
      user.uid = nil

      expect(user).to be_invalid
      expect(user.errors.keys).to include(:uid)
    end

    it "requires a provider" do
      user.provider = nil

      expect(user).to be_invalid
      expect(user.errors.keys).to include(:provider)
    end

    it "uid has to be unique" do
      user.save

      user2 = User.create(uid: "12354")

      expect(user2).to be_invalid
      expect(user2.errors.keys).to include(:uid)
    end
  end

  describe ".initialize_from_omniauth" do
    context "developer auth" do
      let(:user) { User.find_or_create_user(OmniAuth.config.mock_auth[:developer]) }

      it "creates a valid user" do
        expect(user).to be_valid
      end

      context "when it's invalid" do
        it "returns nil" do
          user = User.find_or_create_user({"uid" => "123", "info" => {}})
          expect(user).to be_nil
        end
      end
    end

    context "instagram auth" do
      let(:user) { User.find_or_create_user(OmniAuth.config.mock_auth[:instagram]) }

      it "creates a valid user" do
        expect(user).to be_valid
      end

      context "when it's invalid" do
        it "returns nil" do
          user = User.find_or_create_user({"uid" => "123", "info" => {}})
          expect(user).to be_nil
        end
      end
    end
  end

  describe "#associate_subscription" do
    it "when called on a user object associates the provided twitter subscription" do
      user.save
      twisub = TwiSubscription.create(twitter_id: "@beast")

      user.associate_subscription(twisub)

      expect(user.twi_subscriptions.count).to eq 1
      expect(user.twi_subscriptions).to include(twisub)
    end

    # it "when called on a user object associates the provided instagram subscription" do
    #   user.save
    #   igsub = IgSubscription.create(instagram_id: "@beast")
    #
    #   user.associate_subscription(igsub)
    #
    #   expect(user.ig_subscriptions.count).to eq 1
    #   expect(user.ig_subscriptions).to include(igsub)
    # end
  end

  describe "model associations" do
    it "a user has and belongs to an IG subscription" do
      user.save
      igsub = IgSubscription.create(instagram_id: "@beast")
      igsub.users << user

      expect(igsub.users.first.uid).to eq "12354"
      expect(user.ig_subscriptions.first.instagram_id).to eq "@beast"
    end

    it "a user has and belongs to an Twitter subscription" do
      user.save
      twisub = TwiSubscription.create(twitter_id: "@beast")
      twisub.users << user

      expect(twisub.users.first.uid).to eq "12354"
      expect(user.twi_subscriptions.first.twitter_id).to eq "@beast"
    end
  end
end
