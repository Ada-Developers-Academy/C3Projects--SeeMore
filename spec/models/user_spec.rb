require 'rails_helper'

RSpec.describe User, type: :model do

  let(:user) {
    User.new(
      email: "a@b.com",
      name: "Ada",
      uid: "12354",
      provider: "instagram"
      )
    }

  describe "validations" do
    it "is valid" do
      expect(user).to be_valid
    end

    it "requires a name" do
      user.name = nil

      expect(user).to be_invalid
      expect(user.errors.keys).to include(:name)
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

    it "name has to be unique" do
      user.save

      user2 = User.create(name: "Ada")

      expect(user2).to be_invalid
      expect(user2.errors.keys).to include(:name)
    end

    it "uid has to be unique" do
      user.save

      user2 = User.create(uid: "12354")

      expect(user2).to be_invalid
      expect(user2.errors.keys).to include(:uid)
    end
  end

  describe ".initialize_from_omniauth" do
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

  describe "model associations" do
    it "a user has and belongs to an IG subscription" do
      user = User.create(name: "user1", provider: "developer", uid: "uid1")
      igsub = IgSubscription.create(instagram_id: "@beast")
      igsub.users << user

      expect(igsub.users.first.name).to eq "user1"
      expect(user.ig_subscriptions.first.instagram_id).to eq "@beast"
    end
  end
end
