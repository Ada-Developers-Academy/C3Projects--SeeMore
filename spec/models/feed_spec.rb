require 'rails_helper'

RSpec.describe Feed, type: :model do

  # Associations--------------------------------------------------------
  describe "Associations" do
    before :each do
      @feed = create :feed
    end

    it "has_many posts" do
      post1 = create :post
      post2 = create :post

      expect(@feed.posts.count).to eq 2
    end

    it "has_and_belongs_to_many au_users" do
      user1 = create :au_user
      user2 = create :au_user, uid: 2
      user1.feeds << @feed
      user2.feeds << @feed

      expect(@feed.au_users.count).to eq 2
    end
  end

  # Validations--------------------------------------------------------
  describe "validations" do
    before :each do
      @feed = create :feed
    end

    it "is valid" do
      expect(@feed).to be_valid
    end

    it "requires a name" do
      @feed.name = nil
      expect(@feed).to be_invalid
      expect(@feed.errors.keys).to include(:name)
    end

    it "requires a platform" do
      @feed.platform = nil
      expect(@feed).to be_invalid
      expect(@feed.errors.keys).to include(:platform)
    end

    it "requires a platform_feed_id" do
      @feed.platform_feed_id = nil
      expect(@feed).to be_invalid
      expect(@feed.errors.keys).to include(:platform_feed_id)
    end
  end

  # Scopes--------------------------------------------------------
  describe "scopes" do
    it "shows just feed where platform is instagram" do
      @feed1 = create :feed
      @feed2 = create :feed, platform: "vimeo"
      @feed3 = create :feed, platform: "vimeo"
      @feed4 = create :feed

      expect(Feed.count).to eq 4
      expect(Feed.instagram.count).to eq 2
    end

    it "shows just feed where platform is vimeo" do
      @feed1 = create :feed, platform: "vimeo"
      @feed2 = create :feed, platform: "vimeo"
      @feed3 = create :feed, platform: "vimeo"
      @feed4 = create :feed

      expect(Feed.count).to eq 4
      expect(Feed.vimeo.count).to eq 3
    end

    it "shows just feed where platform is developer" do
      @feed1 = create :feed, platform: "developer"
      @feed2 = create :feed, platform: "vimeo"
      @feed3 = create :feed, platform: "vimeo"
      @feed4 = create :feed

      expect(Feed.count).to eq 4
      expect(Feed.developer.count).to eq 1
    end

    # it "populate_posts after_create method" do
    #   auth = OmniAuth.config.mock_auth[:instagram]
    #   feed = create :feed
    #
    #   # expect(Post.where(feed_id: 1).count).to eq 1
    # end
  end
end
