require 'rails_helper'

RSpec.describe User, type: :model do
  before(:each) do
    # resetting OmniAuth to a consistent state before tests
    OmniAuth.config.mock_auth[:default] = nil
    # OmniAuth.config.mock_auth[:instagram] = nil
  end

  let(:zyn)  {create :user}

  describe "validations" do
      it "is valid" do
        expect(zyn).to be_valid
      end
  end
    #   it "requires an email" do
    #     user.email = nil
    #     expect(user).to be_invalid
    #   end
    #
    #   it "requires a username" do
    #     user.username = nil
    #     expect(user).to be_invalid
    #   end
    #
    #   it "requires a uid" do
    #     user.uid = nil
    #     expect(user).to be_invalid
    #   end
    #
    #   it "requires a provider" do
    #     user.provider = nil
    #     expect(user).to be_invalid
    #   end
    # end
    #
    #
    # describe ".initialize_from_omniauth" do
    #   let(:user) {
    #     User.find_or_create_from_omniauth(OmniAuth.config.mock_auth[:github])
    #     # mock_auth is like a result of an authentication from github
    #   }
    #
    #   it "creates a valid user" do
    #     expect(user).to be_valid
    #   end
    #
    #   context "when it's invalid" do
    #     it "returns nil" do
    #       user = User.find_or_create_from_omniauth({"uid" => "123", "info" => {}})
    #       expect(user).to be_nil
    #     end
    #   end
    # end
  end
