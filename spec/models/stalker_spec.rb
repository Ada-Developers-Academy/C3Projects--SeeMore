require 'rails_helper'

RSpec.describe Stalker, type: :model do
  all_auth_provider_types = [:twitter, :vimeo]

  describe "validations" do
    it "FactoryGirl stalker is valid" do
      stalker = build(:stalker)

      expect(stalker).to be_valid
    end

    describe "username" do
      it "is required" do
        stalker = build(:stalker, username: nil)

        expect(stalker).to be_invalid
        expect(stalker.errors).to include(:username)
      end
    end

    describe "uid" do
      it "is required" do
        stalker = build(:stalker, uid: nil)

        expect(stalker).to be_invalid
        expect(stalker.errors).to include(:uid)
      end
    end

    describe "provider" do
      it "is required" do
        stalker = build(:stalker, provider: nil)

        expect(stalker).to be_invalid
        expect(stalker.errors).to include(:provider)
      end
    end

    describe "unique stalker check" do
      let(:existing_stalker) { create(:stalker) }
      let(:duplicate_stalker) { build(:stalker, uid: existing_stalker.uid, provider: existing_stalker.provider) }

      it "passes unique users" do
        2.times { create(:stalker) }

        expect(Stalker.count).to eq(2)
      end

      it "does not create users with duplicate matching UID & provider" do
        duplicate_stalker # need the existing stalker to exist before the expect block runs

        expect{ duplicate_stalker.save }.not_to change{ Stalker.count }
      end

      it "provides a user-not-unique error" do
        duplicate_stalker.valid?
        expect(duplicate_stalker.errors).to include(:user_not_unique)
      end
    end
  end

  describe ".find_or_create" do
    let(:create_params) { attributes_for(:stalker) }
    let(:invalid_create_params) { { username: "I am a username", uid: nil, provider: nil } }
    let(:stalker) { Stalker.create(create_params) }

    context "when user exists" do
      it "returns an already existing user" do
        stalker # the stalker needs to exist

        expect(Stalker.find_or_create(create_params)).to eq(stalker)
      end
    end

    context "when user doesn't exist" do
      it "creates a new user" do
        expect{ Stalker.find_or_create(create_params) }.to change{ Stalker.count }
      end

      context "when params are invalid" do
        it "does not persist the stalker" do
          expect{ Stalker.find_or_create(invalid_create_params) }.not_to change{ Stalker.count }
        end

        it "returns the not-persisted stalker" do
          expect(Stalker.find_or_create(invalid_create_params)).to be_an_instance_of(Stalker)
        end
      end
    end
  end

  all_auth_provider_types.each do |provider|
    describe ".find_or_create_from_auth_hash (for #{provider})" do
      let(:auth_hash) { OmniAuth.config.mock_auth[provider] }

      context "when user is new" do
        before :each do
          Stalker.find_or_create_from_auth_hash(auth_hash)
        end

        it "creates a new user" do
          expect(Stalker.count).to eq(1)
        end
      end

      context "when user is a repeat visitor" do
        before :each do
          2.times { Stalker.find_or_create_from_auth_hash(auth_hash) }
        end

        it "does not create duplicate users" do
          expect(Stalker.count).to eq(1)
        end
      end
    end
  end

  describe "private methods" do
    describe ".twitter_create_params" do
      let(:formatted_params) { { username: "Ada", uid: "123545", provider: "twitter" } }
      let(:auth_hash) { OmniAuth.config.mock_auth[:twitter] }

      it "returns a formatted hash" do
        expect(Stalker.twitter_create_params(auth_hash)).to eq(formatted_params)
      end

      it "uses the nickname as the username" do
        method_params = Stalker.twitter_create_params(auth_hash)
        expect(auth_hash["info"]["nickname"]).to eq(method_params[:username])
      end
    end

    describe ".vimeo_create_params" do
      let(:formatted_params) { { username: "Ada", uid: "123545", provider: "vimeo" } }
      let(:auth_hash) { OmniAuth.config.mock_auth[:vimeo] }

      it "returns a formatted hash" do
        expect(Stalker.vimeo_create_params(auth_hash)).to eq(formatted_params)
      end

      it "uses the name as the username" do
        method_params = Stalker.vimeo_create_params(auth_hash)
        expect(auth_hash["info"]["name"]).to eq(method_params[:username])
      end
    end

    describe ".create_params_by_provider" do
      context "the provider is Twitter" do
        let(:formatted_params) { { username: "Ada", uid: "123545", provider: "twitter" } }
        let(:auth_hash) { OmniAuth.config.mock_auth[:twitter] }

        it "returns formatted params" do
          expect(Stalker.create_params_by_provider(auth_hash)).to eq(formatted_params)
        end
      end

      context "the provider is Vimeo" do
        let(:formatted_params) { { username: "Ada", uid: "123545", provider: "vimeo" } }
        let(:auth_hash) { OmniAuth.config.mock_auth[:vimeo] }

        it "returns formatted params" do
          expect(Stalker.create_params_by_provider(auth_hash)).to eq(formatted_params)
        end
      end

      context "when provider is not recognized" do
        it "raises NotImplemented error" do
          auth_hash = OmniAuth.config.mock_auth[:unrecognized]

          expect{ Stalker.create_params_by_provider(auth_hash) }.to raise_error(NotImplementedError)
        end
      end
    end
  end
end
