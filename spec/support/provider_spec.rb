require 'spec_helper'

RSpec.shared_examples "a provider" do


  describe "model validations" do
    before :each do
      user1 = create :user
      user2 = create :user, username: "Ada2", uid: "34524"
    end

    it "requires a username" do
      provider = build described_class, username: nil

      expect(provider).not_to be_valid
      expect(provider.errors.keys).to include(:username)
    end

    it "username must be unique" do
      create described_class
      provider2 = build described_class

      expect(provider2).not_to be_valid
      expect(described_class.count).to be 1
      expect(provider2.errors.keys).to include(:username)
    end

    it "requires a provider_id" do
      provider = build described_class, provider_id: nil

      expect(provider).not_to be_valid
      expect(provider.errors.keys).to include(:provider_id)
    end

    it "provider_id must be unique" do
      create described_class
      provider2 = build described_class

      expect(provider2).not_to be_valid
      expect(described_class.count).to be 1
      expect(provider2.errors.keys).to include(:provider_id)
    end

    it "validates a valid record" do
      provider = create described_class
      expect(described_class.count).to be 1
      expect(described_class.all).to include(provider)
    end
  end
end
