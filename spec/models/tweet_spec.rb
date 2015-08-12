require 'rails_helper'
require 'support/vcr_setup'
require 'twit_init'

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
      tweet = build :tweet, created_time: nil
      tweet.valid?
      expect(tweet.errors.keys).to include(:created_time)
    end

    it "requires a tweet tw_user_id_str" do
      tweet = build :tweet, tw_user_id_str: nil
      tweet.valid?
      expect(tweet.errors.keys).to include(:tw_user_id_str)
    end

    it "requires a tweet tw_user_id foreign key" do
      tweet = build :tweet, tw_user_id: nil
      tweet.valid?
      expect(tweet.errors.keys).to include(:tw_user_id)
    end
  end

  describe "scope #chron_tweets" do
    it "returns the tweets in chronological order with most recent last" do
      tweet1 = create :tweet
      tweet2 = create :tweet, tw_id_str: "600", created_time: "2015-08-06 16:07:59 -0700"
      tweet3 = create :tweet, tw_id_str: "700", created_time: "2015-08-06 17:07:59 -0700"
      recent_tweets = [tweet3, tweet2, tweet1]
      expect(Tweet.all.chron_tweets).to eq(recent_tweets)
    end
  end

  describe "methods" do
    describe "self.update_timeline(user)" do
      context "user has newly followed the twitter user" do
        it "save the last five most recent tweets" do
          user = create :user
          tw_user = TwUser.create({tw_user_id_str: "111868320"})
          user.tw_users << tw_user
          VCR.use_cassette 'controller/twitter_user_timeline_api_response' do
            Tweet.update_timeline(user)
            expect(Tweet.all.count).to eq 5 #recent tweets instead? would be 5
          end
        end
      end

      context "the user has been following the twitter user" do
        it "saves latest tweets since the last update" do
          user = create :user
          tw_user = TwUser.create({ tw_user_id_str: "111868320" })
          user.tw_users << tw_user
          tweet = Tweet.create({ tw_id_str: "631224940012765184", created_time: "2015-08-11 22:05:27 +0000", tw_user_id: 1, tw_user_id_str: "111868320"})
          VCR.use_cassette 'controller/twitter_timeline_following_api_response' do
            Tweet.update_timeline(user)
            expect(Tweet.all.count).to eq 2
          end
        end
      end
    end
  end
end
