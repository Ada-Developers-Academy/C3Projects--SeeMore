require 'rails_helper'

RSpec.describe Tweet, type: :model do
  describe "model validations" do
    before :each do
      user1 = create :user
      user2 = create :user, username: "Ada2", uid: "34524"
    end

    it "requires a username" do
      tweet = build :tweet, username: nil

      expect(tweet).not_to be_valid
      expect(tweet.errors.keys).to include(:username)
    end

    it "username must be unique" do
      create :tweet
      tweet2 = build :tweet

      expect(tweet2).not_to be_valid
      expect(Tweet.count).to be 1
      expect(tweet2.errors.keys).to include(:username)
    end

    it "requires a provider_id" do
      tweet = build :tweet, provider_id: nil

      expect(tweet).not_to be_valid
      expect(tweet.errors.keys).to include(:provider_id)
    end

    it "provider_id must be unique" do
      create :tweet
      tweet2 = build :tweet

      expect(tweet2).not_to be_valid
      expect(Tweet.count).to be 1
      expect(tweet2.errors.keys).to include(:provider_id)
    end

    it "validates a valid record" do
      tweet = create :tweet
      expect(Tweet.count).to be 1
      expect(Tweet.all).to include(tweet)
    end
  end
end
