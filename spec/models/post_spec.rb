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

  pending ".seed_tweets"
  # def self.seed_tweets(prey_uid, prey_id, count = SEED_COUNT)
  #   tweets = TwitterClient.fetch_tweets(prey_uid, { count: count })
  #   create_many_posts(tweets, prey_id)
  # end

  pending ".update_tweets"
  # def self.update_tweets(prey_uid, prey_id)
  #   last_tweet_uid = Prey.last_post_uid(prey_uid)
  #   tweets = TwitterClient.fetch_tweets(prey_uid, { since_id: last_tweet_uid })
  #   create_many_posts(tweets, prey_id)
  # end

  pending ".seed_grams"
  # def self.seed_grams(prey_uid, prey_id, count = SEED_COUNT)
  #   grams = InstagramClient.seed_grams(prey_uid, count)
  #   create_many_posts(grams, prey_id)
  # end

  pending ".update_grams"
  # def self.update_grams(prey_uid, prey_id)
  #   last_gram_uid = Prey.last_post_uid(prey_uid)
  #   grams = InstagramClient.update_grams(prey_uid, last_gram_uid)
  #   create_many_posts(grams, prey_id)
  # end

  describe "private methods" do
    pending ".create_many_posts"
    # private
    # def self.create_many_posts(posts, prey_id)
    #   return if posts.nil?
    #   posts.each do |post_hash|
    #     media = post_hash[:media]
    #     post_hash.delete(:media)

    #     post = Post.new(post_hash)
    #     post.prey_id = prey_id
    #     post.save

    #     media.each do |medium_url|
    #       Medium.create(url: medium_url, post_id: post.id)
    #     end
    #   end
    # end

  end
end
