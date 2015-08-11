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
  end

  pending ".seed_tweets"
  pending ".seed_grams"
  pending ".update_tweets"
  pending ".update_grams"
end
