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
    end

    it "requires a content" do
      @post.content = nil
      expect(@post).to be_invalid
    end

    it "requires a date_posted" do
      @post.date_posted = nil
      expect(@post).to be_invalid
    end

    it "requires a feed_id" do
      @post.feed_id = nil
      expect(@post).to be_invalid
    end
  end


  # describe ".initialize_from_omniauth" do
  #   let(:post) { Post.find_or_create_from_omniauth(OmniAuth.config.mock_auth[:instagram]) }
  #
  #   it "creates a valid post" do
  #     expect(post).to be_valid
  #   end
  #
  #   context "when it's invalid" do
  #     it "returns nil" do
  #       post = Post.find_or_create_from_omniauth({"uid" => "123", "data" => {}})
  #       expect(post).to be_nil
  #     end
  #   end
  # end
end
