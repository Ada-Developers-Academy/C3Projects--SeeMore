require 'rails_helper'

RSpec.describe Post, type: :model do
    let(:twisub) { build(:twi_sub) }
    let(:user)   { build(:user) }
    let(:post)   { build(:post) }

  describe "model associations" do
    it "belongs to a subscription" do
      twisub.save
      post.save

      expect(post.subscriptions.first.id).to eq 1
      expect(twisub.posts.first).to eq post
    end

    it "has users through subscriptions" do
      user.save
      twisub.save
      post.save

      expect(post.users.first.id).to eq 1
    end
  end

  describe "model validations" do


  end
end
