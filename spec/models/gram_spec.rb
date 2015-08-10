require 'rails_helper'

RSpec.describe Gram, type: :model do
  describe "scope #latest_posts(limit)" do
    before :each do
      3.times do
        create :gram
      end

      @post4 = create :gram
      @post5 = create :gram
    end

    it "retrieves the latest posts" do
      posts = Gram.latest_posts(2)

      expect(posts).to include @post4
      expect(posts).to include @post5
    end

    it "returns number of posts according to limit parameter" do
      three_posts = Gram.latest_posts(3)
      one_post = Gram.latest_posts(1)

      expect(three_posts.count).to eq 3
      expect(one_post.count).to eq 1
    end

    it "returns posts in reverse chronological order" do
      posts = Gram.latest_posts(3)

      expect(posts[0].created_at).to be > posts[1].created_at
      expect(posts[1].created_at).to be > posts[2].created_at
      expect(posts[2].created_at).to be < posts[0].created_at
    end
  end
end
