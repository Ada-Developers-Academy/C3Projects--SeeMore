require 'rails_helper'

RSpec.describe Tweet, type: :model do
  describe "model validations" do
    it "creates a valid Tweet" do
      tweet = build(:tweet)

      expect(tweet).to be_valid
    end

    it "requires uid" do
      tweet = build(:tweet, uid: nil)

      expect(tweet).to be_invalid
      expect(tweet.errors).to include(:uid)
    end

    it "requires post_time" do
      tweet = build(:tweet, post_time: nil)

      expect(tweet).to be_invalid
      expect(tweet.errors).to include(:post_time)
    end

    it "requires prey_id" do
      tweet = build(:tweet, prey_id: nil)

      expect(tweet).to be_invalid
      expect(tweet.errors).to include(:prey_id)
    end

    it "requires url" do
      tweet = build(:tweet, url: nil)

      expect(tweet).to be_invalid
      expect(tweet.errors).to include(:url)
    end
  end

  pending ".seed_tweets"
  pending ".update_tweets"
  pending ".create_many_from_api"
end
