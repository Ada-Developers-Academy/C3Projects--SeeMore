require 'spec_helper'

RSpec.shared_examples "a post" do
  describe "model validations" do
    before :each do
      create :user
    end

    it "requires a post_id" do
      post = build described_class, post_id: nil

      expect(post).not_to be_valid
      expect(post.errors.keys).to include(:post_id)
    end

    it "post_id must be unique" do
      create described_class
      post2 = build described_class

      expect(post2).not_to be_valid
      expect(described_class.count).to be 1
      expect(post2.errors.keys).to include(:post_id)
    end

    it "requires a foreign key for the corresponding social media user model" do
      post = build described_class, foreign_key => nil

      expect(post).not_to be_valid
      expect(post.errors.keys).to include(foreign_key)
    end

    it "validates a valid record" do
      post = create described_class
      expect(described_class.count).to be 1
      expect(described_class.all).to include(post)
    end
  end
end
