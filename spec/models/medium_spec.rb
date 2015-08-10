require 'rails_helper'

RSpec.describe Medium, type: :model do
  describe "model validations" do
    it "creates valid TweetMedium" do
      medium = build(:medium)
      expect(medium).to be_valid
    end

    it "requires tweet_id" do
      medium = build(:medium, post_id: nil)

      expect(medium).to be_invalid
      expect(medium.errors).to include(:post_id)
    end

    it "requires url" do
      medium = build(:medium, url: nil)

      expect(medium).to be_invalid
      expect(medium.errors).to include(:url)
    end
  end
end
