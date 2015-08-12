require 'rails_helper'

RSpec.describe AuUser, type: :model do
  context "creating a new user" do
    describe "validations" do

      it "name is required" do
        au_user = build :au_user, name: nil

        expect(au_user).to_not be_valid
        expect(au_user.errors.keys).to include(:name)
      end

      it "uid is required" do
        au_user = build :au_user, uid: nil

        expect(au_user).to_not be_valid
        expect(au_user.errors.keys).to include(:uid)
      end

      it "provider is required" do
        au_user = build :au_user, provider: nil

        expect(au_user).to_not be_valid
        expect(au_user.errors.keys).to include(:provider)
      end
    end

    describe "associations" do
      let(:au_user) { create :au_user }
      let(:feed) { create :feed }
      let(:post) { create :post }
      it "authorized users have many feeds" do
        au_user.feeds << feed
        expect(au_user.feeds).to include(feed)
      end
    end
  end

  describe "omni auth model method" do
    context "auth hash without avatar" do
      let (:user) { AuUser.create_with_omniauth(OmniAuth.config.mock_auth[:vimeo]) }
      it "assigns values to the user via the provider" do
        expect(user.uid).to eq(OmniAuth.config.mock_auth[:vimeo]["uid"])
      end

      it "controls for accounts without avatars" do
        expect(user.avatar).to eq (OmniAuth.config.mock_auth[:vimeo]["avatar"])
      end
    end
  end
end
