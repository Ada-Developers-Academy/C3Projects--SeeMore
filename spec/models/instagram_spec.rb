require 'rails_helper'

RSpec.describe Instagram, type: :model do
  describe "model validations" do
    before :each do
      user1 = create :user
      user2 = create :user, username: "Ada2", uid: "34524"
    end

    it "requires a username" do
      instagram = build :instagram, username: nil

      expect(instagram).not_to be_valid
      expect(instagram.errors.keys).to include(:username)
    end

    it "username must be unique" do
      create :instagram
      instagram2 = build :instagram

      expect(instagram2).not_to be_valid
      expect(Instagram.count).to be 1
      expect(instagram2.errors.keys).to include(:username)
    end

    it "requires a provider_id" do
      instagram = build :instagram, provider_id: nil

      expect(instagram).not_to be_valid
      expect(instagram.errors.keys).to include(:provider_id)
    end

    it "provider_id must be unique" do
      create :instagram
      instagram2 = build :instagram

      expect(instagram2).not_to be_valid
      expect(Instagram.count).to be 1
      expect(instagram2.errors.keys).to include(:provider_id)
    end

    it "validates a valid record" do
      instagram = create :instagram
      expect(Instagram.count).to be 1
      expect(Instagram.all).to include(instagram)
    end
  end
end
