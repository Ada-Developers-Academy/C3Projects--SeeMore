require 'rails_helper'

RSpec.describe User, type: :model do
  before(:each) do
    # resetting OmniAuth to a consistent state before tests
    OmniAuth.config.mock_auth[:instagram] = nil
    # OmniAuth.config.mock_auth[:instagram] = nil
  end

  let(:zyn)  {create :user}

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
      # let(:petunia) {
      #   User.find_or_create_from_omniauth(OmniAuth.config.mock_auth[:instagram])
      #   # mock_auth is like a result of an authentication from github
      # }

      it "creates a valid user" do
        binding.pry
        petunia =   User.find_or_create_from_omniauth(OmniAuth.config.mock_auth[:instagram])
        expect(petunia).to be_valid
      end

      context "when it's invalid" do
        it "returns nil" do
          user = User.find_or_create_from_omniauth({"uid" => "123", "info" => {}})
          expect(user).to be_nil
        end

        it "returns nil" do
          user = User.find_or_create_from_omniauth({"uid" => nil, "info" => {}})
          expect(user).to be_nil
        end

      end
    end
  end
