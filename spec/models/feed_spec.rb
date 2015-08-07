require 'rails_helper'

RSpec.describe Feed, type: :model do
  describe "validations" do
    before :each do
      @feed = create :feed
    end

    it "is valid" do
      expect(@feed).to be_valid
    end

    it "requires a name" do
      @feed.name = nil
      expect(@feed).to be_invalid
      expect(@feed.errors.keys).to include(:name)
    end

    it "requires a platform" do
      @feed.platform = nil
      expect(@feed).to be_invalid
      expect(@feed.errors.keys).to include(:platform)

    end

    it "requires a platform_feed_id" do
      @feed.platform_feed_id = nil
      expect(@feed).to be_invalid
      expect(@feed.errors.keys).to include(:platform_feed_id)
    end
  end
end
