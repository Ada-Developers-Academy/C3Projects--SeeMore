require 'rails_helper'
# require 'webmock/rspec'

RSpec.describe Feed, type: :model do

  # Associations--------------------------------------------------------
  describe "Associations" do
    before :each do
      # Skip the populate_posts method, so It doesn't have to use the internet
      allow_any_instance_of(Feed).to receive(:populate_posts)
      @feed = create :feed
    end

    it "has_many posts" do
      post1 = create :post
      post2 = create :post

      expect(@feed.posts.count).to eq 2
    end

    it "destroys all posts when it is destroyed" do
      post1 = create :post
      post2 = create :post
      @feed.destroy
      expect{ post1.reload }.to raise_exception(ActiveRecord::RecordNotFound)
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
      allow_any_instance_of(Feed).to receive(:populate_posts)
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
    before :each do
      allow_any_instance_of(Feed).to receive(:populate_posts)
    end

    it "shows just feed where platform is instagram" do
      @feed1 = create :feed, platform: "Instagram"
      @feed2 = create :feed, platform: "Vimeo"
      @feed3 = create :feed, platform: "Vimeo"
      @feed4 = create :feed, platform: "Instagram"

      expect(Feed.count).to eq 4
      expect(Feed.instagram.count).to eq 2
    end

    it "shows just feed where platform is vimeo" do
      @feed1 = create :feed, platform: "Vimeo"
      @feed2 = create :feed, platform: "Vimeo"
      @feed3 = create :feed, platform: "Vimeo"
      @feed4 = create :feed

      expect(Feed.count).to eq 4
      expect(Feed.vimeo.count).to eq 3
    end

    it "shows just feed where platform is developer" do
      @feed1 = create :feed, platform: "Developer"
      @feed2 = create :feed, platform: "Vimeo"
      @feed3 = create :feed, platform: "Vimeo"
      @feed4 = create :feed

      expect(Feed.count).to eq 4
      expect(Feed.developer.count).to eq 1
    end

    context ":alphabetical" do
      it "shows feeds in alphabetical order by name" do
        feed1 = create :feed, name: "apples"
        feed2 = create :feed, name: "zoidberg"
        feed3 = create :feed, name: "potatoes"
        feed4 = create :feed, name: "aardvark"

        expect(Feed.second.name).to eq("zoidberg")
        expect(Feed.alphabetical.second.name).to eq("apples")
      end

      it "irrespective of capitalization" do
        feed1 = create :feed, name: "apples"
        feed2 = create :feed, name: "Zoidberg"
        feed3 = create :feed, name: "zilch"

        expect(Feed.order("name ASC").first.name).to eq("Zoidberg")
        expect(Feed.alphabetical.first.name).to eq("apples")
      end
    end
  end

  describe 'populates posts after create method' do
    it "gets a response from an api" do

      VCR.use_cassette("user_instagram", record: :new_episodes) do
        feed = create :user_instagram
      end

      expect(Post.count).to eq 19
    end
  end
end
