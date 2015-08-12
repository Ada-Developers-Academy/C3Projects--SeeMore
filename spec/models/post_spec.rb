require 'rails_helper'

RSpec.describe Post, type: :model do
  describe "model validations" do
    it "creates a valid Post" do
      post = build(:post)

      expect(post).to be_valid
    end

    it "requires uid" do
      post = build(:post, uid: nil)

      expect(post).to be_invalid
      expect(post.errors).to include(:uid)
    end

    it "requires post_time" do
      post = build(:post, post_time: nil)

      expect(post).to be_invalid
      expect(post.errors).to include(:post_time)
    end

    it "requires prey_id" do
      post = build(:post, prey_id: nil)

      expect(post).to be_invalid
      expect(post.errors).to include(:prey_id)
    end

    it "requires url" do
      post = build(:post, url: nil)

      expect(post).to be_invalid
      expect(post.errors).to include(:url)
    end

    it "requires provider" do
      post = build(:post, provider: nil)

      expect(post).to be_invalid
      expect(post.errors).to include(:provider)
    end

    it "requires a unique uid" do
      create(:post, uid: "123")
      post2 = build(:post, uid: "123")

      expect(post2).to be_invalid
      expect(post2.errors).to include(:uid)
    end
  end

  describe ".seed_tweets" do
    before :each do
      VCR.use_cassette('seeds_5_tweets') do
        prey = Prey.new({ name: "Ashley Watkins",
          username: "catchingash",
          provider: "twitter",
          uid: "3037739230",
          photo_url: "https://pbs.twimg.com/profile_images/625870213901193216/usGZawYA_normal.jpg",
          profile_url: "https://twitter.com/catchingash"
        })
        allow(prey).to receive(:seed_posts).and_return(true)
        prey.save
      end
    end

    it "seeds with the last 5 tweets" do
      VCR.use_cassette('seeds_5_tweets') do
        response = TwitterClient.fetch_tweets("3037739230", { count: 5 })
        Post.send(:create_many_tweets_from_api, response)
        expect(Post.count).to eq(5)
      end
    end

    it "returns params" do
      VCR.use_cassette('seeds_5_tweets') do
        response = TwitterClient.fetch_tweets("3037739230", { count: 5 })
        params = Post.send(:create_tweet_params_from_api, response.first)
        expect(params).to eq(5)
      end
    end
  end

  # describe ".create_many_tweets_from_api" do
  #   it
  # end

  pending ".seed_tweets"
  # def self.seed_tweets(prey_uid, count = SEED_COUNT)
  #   tweets = TwitterClient.fetch_tweets(prey_uid, { count: count })
  #   create_many_tweets_from_api(tweets)
  # end

  pending ".update_tweets"
  # def self.update_tweets(prey_uid)
  #   last_tweet_uid = Prey.last_post_uid(prey_uid)
  #   tweets = TwitterClient.fetch_tweets(prey_uid, { since_id: last_tweet_uid })
  #   create_many_tweets_from_api(tweets)
  # end

  pending ".seed_grams"
  # def self.seed_grams(prey_uid, count = SEED_COUNT)
  #   grams = InstagramClient.seed_grams(prey_uid, count)
  #   create_many_grams_from_api(grams)
  # end

  pending ".update_grams"
  # def self.update_grams(prey_uid)
  #   last_gram_uid = Prey.last_post_uid(prey_uid)
  #   grams = InstagramClient.update_grams(prey_uid, last_gram_uid)
  #   create_many_grams_from_api(grams)
  # end

  describe "private methods" do
    pending ".create_many_tweets_from_api"
    # def self.create_many_tweets_from_api(tweets)
    #   tweets.each do |tweet|
    #     post_id = Post.create(create_tweet_params_from_api(tweet)).id
    #     tweet.media.each do |medium|
    #       Medium.create(url: medium.media_url_https.to_s, post_id: post_id)
    #     end
    #   end
    # end

    pending ".tweet_create_params_from_api"
    # def self.create_tweet_params_from_api(tweet)
    #   { uid: tweet.id,
    #     body:  tweet.text,
    #     post_time: tweet.created_at,
    #     prey_id: Prey.find_by(uid: tweet.user.id).id,
    #     url: tweet.url,
    #     provider: "twitter"
    #   }
    # end

    pending ".create_many_grams_from_api"
    # def self.create_many_grams_from_api(grams)
    #   grams.each do |gram|
    #     post = Post.create(create_gram_params_from_api(gram))
    #     Medium.create(url: gram["images"]["standard_resolution"]["url"], post_id: post.id)
    #   end
    # end

    pending "create_gram_params_from_api"
    # def self.create_gram_params_from_api(gram)
    #   { uid: gram["id"],
    #     body: (gram["caption"]["text"] unless gram["caption"].nil?),
    #     post_time: convert_unix_to_datetime(gram["created_time"]),
    #     prey_id: Prey.find_by(uid: gram["user"]["id"]).id,
    #     url: gram["link"],
    #     provider: "instagram"
    #   }
    # end

    pending ".convert_unix_to_datetime"
    # def self.convert_unix_to_datetime(time)
    #   Time.at(time.to_i).to_datetime
    # end
  end
end
