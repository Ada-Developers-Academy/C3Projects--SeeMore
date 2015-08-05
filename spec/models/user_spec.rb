require 'rails_helper'

RSpec.describe User, type: :model do

  context "user logging in with developer 'strategy'" do
    describe "validations" do
      let(:dev_user) { build :user }

      it "is valid" do
        expect(dev_user).to be_valid
      end

      it "requires a username" do
        dev_user.username = nil
        expect(dev_user).to be_invalid
      end

      it "requires a uid" do
        dev_user.uid = nil
        expect(dev_user).to be_invalid
      end

      it "requires a provider" do
        dev_user.provider = nil
        expect(dev_user).to be_invalid
      end
    end


    describe ".initialize_from_omniauth" do
      let(:user) {
        User.find_or_create_from_omniauth(OmniAuth.config.mock_auth[:developer])
      }

      it "creates a valid user" do
        expect(user).to be_valid
      end

      context "when it's invalid" do
        it "returns nil" do
          user = User.find_or_create_from_omniauth({
            uid: "123", info: { }
            })
          expect(user).to be_nil
        end
      end
    end
  end

  context "user logging in with instagram" do
    describe "validations" do
      let(:ig_user) { build :user, provider: :instagram }

      it "is valid" do
        expect(ig_user).to be_valid
      end

      it "requires a username" do
        ig_user.username = nil
        expect(ig_user).to be_invalid
      end

      it "requires a uid" do
        ig_user.uid = nil
        expect(ig_user).to be_invalid
      end

      it "requires a provider" do
        ig_user.provider = nil
        expect(ig_user).to be_invalid
      end
    end

    describe ".initialize_from_omniauth" do
      let(:user) {
        User.find_or_create_from_omniauth(OmniAuth.config.mock_auth[:instagram])
      }

      it "creates a valid user" do
        expect(user).to be_valid
      end

      context "when it's invalid" do
        it "returns nil" do
          user = User.find_or_create_from_omniauth({
            uid: "123", info: { }
            })
          expect(user).to be_nil
        end
      end
    end
  end

end
