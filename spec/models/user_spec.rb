require 'spec_helper'
require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { create :user }

  describe "validations" do
    it "is valid" do
      expect(user).to be_valid
    end

    it "requires a username" do
      user.username = nil
      expect(user).to be_invalid
    end

    it "requires a uid" do
      user.uid = nil
      expect(user).to be_invalid
    end

     it "requires an avatar_url" do
      user.avatar_url = nil
      expect(user).to be_invalid
    end

    it "requires a provider" do
      user.provider = nil
      expect(user).to be_invalid
    end
  end


  describe ".initialize_from_omniauth" do
    let(:user) { User.find_or_create_from_omniauth(OmniAuth.config.mock_auth[:instagram]) }

    it "creates a valid user" do
      expect(user).to be_valid
    end

    context "when it's invalid" do
      it "returns nil" do
        user = User.find_or_create_from_omniauth({"id" => "123","user" => {"username" => "nil"}})
        expect(user).to be_nil
      end
    end
  end

  describe "#ig_follow" do
    let(:user) { create :user }
    let(:ig_user) { create :instagram_user }

    it "creates an association between the user and IG account" do
      user.ig_follow(ig_user)
      expect(user.instagram_users).to include ig_user
    end
  end
end
