require 'rails_helper'
require 'httparty'

RSpec.describe Post, type: :model do
    let(:twisub) { build(:twi_sub) }
    let(:user)   { build(:user) }
    let(:post)   { build(:post) }

  describe "model associations" do
    it "belongs to a subscription" do
      twisub.save
      post.save

      expect(post.subscription.id).to eq 1
      expect(twisub.posts.first).to eq post
    end

    it "has users through subscriptions" do
      user.save
      twisub.save
      user.subscriptions << twisub
      post.save

      expect(post.users.first).to eq user
    end
  end

  describe "model validations" do

    it "is valid with a username, posted_at, content_id and subscription_id" do
      post.save

      expect(post).to be_valid
    end

    it "won't create a post without a username" do
      no_user = build(:post, username: nil)

      expect(no_user).to be_invalid
      expect(no_user.errors.keys).to include(:username)
    end

    it "won't create a post without a posted_at" do
      no_postdate = build(:post, posted_at: nil)

      expect(no_postdate).to be_invalid
      expect(no_postdate.errors.keys).to include(:posted_at)
    end

    it "won't create a post without a content_id" do
      no_content = build(:post, content_id: nil)

      expect(no_content).to be_invalid
      expect(no_content.errors.keys).to include(:content_id)
    end

    it "won't create a post without a subscription_id" do
      no_sub = build(:post, subscription_id: nil)

      expect(no_sub).to be_invalid
      expect(no_sub.errors.keys).to include(:subscription_id)
    end
  end

  describe "post model methods" do
    # context "create_all_instagram_posts" do
    #   it "takes array of HTTParty objects, and finds in db or creates new posts" do

    #     VCR.use_cassette('instagram refresh 1') do

    #       array_of_httparty_objects = ENV["INSTAGRAM_RESPONSE"]
    #       array_of_httparty_objects.to_a

    #       Post.create_all_instagram_posts(array_of_httparty_objects)

    #       expect(Post.count).to eq 15
    #     end
    #   end
    # end

    context "#create_instagram_post" do
      before :each do
        create :post
      end

      it "saves a new post to the db if it does not already exist " do
        newed_post = build :post, content_id: "7890"

        Post.create_instagram_post(newed_post)

        expect(Post.count).to eq 2
      end

      it "does not save a newed post if the content id already exists" do
        newed_post = build :post

        Post.create_instagram_post(newed_post)

        expect(Post.count).to eq 1
      end
    end

    context "create_twitter_posts" do

    end
  end
end
