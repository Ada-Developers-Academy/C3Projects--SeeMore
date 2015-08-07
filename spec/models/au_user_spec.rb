require 'rails_helper'

RSpec.describe AuUser, type: :model do
  context "creating a new user" do
    describe "validations" do

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

    # describe "associations" do
    #   let(:au_user) { create :au_user }
    #   let(:feed) { create :feed }
    #   let(:post) { create :post }
    #   it "authorized users have many feeds" do
    #     au_user.feeds << feed
    #     expect(au_user.feeds).to include(feed)
    #   end
    # end
  end

  describe "omni auth model method" do
    it "assigns values to the user via the provider" do
      au_user = AuUser.new
      auth = OmniAuth.config.mock_auth[:vimeo]
      expect(au_user.create_with_omniauth(auth).uid).to eq(auth["uid"])
    end
  end
end
