require 'rails_helper'

RSpec.describe Post, type: :model do

  # Associations--------------------------------------------------------
  describe "Associations" do
    it "belongs_to feed" do
      post = create :post
      feed = create :feed

    expect(feed.posts.count).to eq 1
    end
  end

  # Validations--------------------------------------------------------
  describe "validations" do
    before :each do
      @post = create :post
    end

    it "is valid" do
      expect(@post).to be_valid
    end

    it "requires a description" do
      @post.description = nil
      expect(@post).to be_invalid
      expect(@post.errors.keys).to include(:description)
    end

    it "requires a content" do
      @post.content = nil
      expect(@post).to be_invalid
      expect(@post.errors.keys).to include(:content)
    end

    it "requires a date_posted" do
      @post.date_posted = nil
      expect(@post).to be_invalid
      expect(@post.errors.keys).to include(:date_posted)
    end

    it "requires a feed_id" do
      @post.feed_id = nil
      expect(@post).to be_invalid
      expect(@post.errors.keys).to include(:feed_id)
    end
  end

  # Scopes--------------------------------------------------------
  describe "Scopes" do
    it "has 'chronological' scope" do
      post1 = create :post
      post2 = create :post, date_posted: Date.parse("August 2015")
      post3 = create :post, date_posted: Date.parse("August 2014")
      post4 = create :post, date_posted: Date.parse("August 2013")

      chronological_order = post2, post3, post1, post4
      expect(Post.chronological).to eq chronological_order
    end

    it "has 'only_thirty' scope" do
      35.times do
        post = create :post
      end

      expect(Post.only_thirty.count).to eq 30
    end
  end
end
