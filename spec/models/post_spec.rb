require 'rails_helper'

RSpec.describe Post, type: :model do
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
end
