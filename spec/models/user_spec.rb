require 'rails_helper'

RSpec.describe User, type: :model do
  let(:zyn)  { create :user }

  describe "validations" do
      it "is valid" do
        expect(zyn).to be_valid
      end

      it "requires a uid" do
        zyn.uid = nil
        expect(zyn).to be_invalid
      end

      it "requires a provider" do
        zyn.provider = nil
        expect(zyn).to be_invalid
      end
  end # validations

  describe ".find_or_create_from_omniauth" do
    context "when user has already been created" do
      it "finds the correct user" do
        maebe = create :user, uid: "123", provider: "instagram"
        user = User.find_or_create_from_omniauth({
          "uid" => "123",
          "provider" => "instagram",
          "info" => {}
        })

        expect(user).to eq(maebe)
      end
    end # context

    context "when user has already been created" do
      let(:petunia) {
        User.find_or_create_from_omniauth(OmniAuth.config.mock_auth[:instagram])
        # mock_auth is like a result of an authentication from github
      }

      it "user auth is valid" do
        expect(petunia).to be_valid
      end
    end # context

    context "when omniauth is invalid" do
      it "returns nil" do
        user = User.find_or_create_from_omniauth({"uid" => nil, "provider" => "instagram", "info" => {}})
        expect(user).to be_nil
      end

      it "returns nil" do
        user = User.find_or_create_from_omniauth({"uid" => nil, "info" => {}})
        expect(user).to be_nil
      end
    end # context

  end # describe
end
