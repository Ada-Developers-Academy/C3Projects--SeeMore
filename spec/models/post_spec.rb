require 'rails_helper'

RSpec.describe Post, type: :model do
  describe "validations" do
    let(:post) { build :post }

    it "requires a followee_id" do
      post.followee_id = nil
      post.valid?
      expect(post.errors.keys).to include(:followee_id)
    end

    it "requires a source" do
      post.source = nil
      post.valid?
      expect(post.errors.keys).to include(:source)
    end

    it "requires a native_created_at" do
      post.native_created_at = nil
      post.valid?
      expect(post.errors.keys).to include(:native_created_at)
    end

    it "requires a native_created_at" do
      post.native_id = nil
      post.valid?
      expect(post.errors.keys).to include(:native_id)
    end
  end

  describe "assocations" do
    let(:post) { create :post }

    it "responds to 'followee' method call" do
      expect(post).to respond_to(:followee)
    end
  end
end
