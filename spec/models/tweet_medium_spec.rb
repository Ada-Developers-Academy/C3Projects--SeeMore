require 'rails_helper'

RSpec.describe TweetMedium, type: :model do
  describe "model validations" do
    it "creates valid TweetMedium" do
      medium = build(:tweet_medium)
      expect(medium).to be_valid
    end

    it "requires tweet_id" do
      medium = build(:tweet_medium, tweet_id: nil)

      expect(medium).to be_invalid
      expect(medium.errors).to include(:tweet_id)
    end

    it "requires url" do
      medium = build(:tweet_medium, url: nil)

      expect(medium).to be_invalid
      expect(medium.errors).to include(:url)
    end
  end
end
