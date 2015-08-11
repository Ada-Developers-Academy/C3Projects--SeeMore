require 'rails_helper'

RSpec.describe Tweet, type: :model do

  describe "validations" do

    context "tweet ids" do
      it "requires a tweet id" do
        tweet = build :tweet, tw_id_str: nil
        tweet.valid?
        expect(tweet.errors.keys).to include(:tw_id_str)
      end

      it "requires unique tweet ids" do
        create :tweet
        tweet = build :tweet
        tweet.valid?
        expect(tweet.errors.messages).to include(:tw_id_str => ["has already been taken"])
      end
    end

    it "requires a tweet created_at time" do
      tweet = build :tweet, tw_created_at: nil
      tweet.valid?
      expect(tweet.errors.keys).to include(:tw_created_at)
    end

    it "requires a tweet tw_user_id_str" do
      tweet = build :tweet, tw_user_id_str: nil
      tweet.valid?
      expect(tweet.errors.keys).to include(:tw_user_id_str)
    end
  end
end
