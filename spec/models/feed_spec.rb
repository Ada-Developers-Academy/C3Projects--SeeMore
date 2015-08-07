require 'rails_helper'

RSpec.describe Feed, type: :model do
  describe "validations" do
    before :each do
      @feed = create :feed
    end

    it "is valid" do
      expect(@feed).to be_valid
    end

    it "requires a description" do
      @feed.name = nil
      expect(@feed).to be_invalid
    end

    it "requires a content" do
      @feed.platform = nil
      expect(@feed).to be_invalid
    end

    it "requires a date_posted" do
      @feed.platform_feed_id = nil
      expect(@feed).to be_invalid
    end
  end
end
