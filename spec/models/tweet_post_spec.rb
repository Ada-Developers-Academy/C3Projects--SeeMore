require 'rails_helper'

RSpec.describe TweetPost, type: :model do
  it_behaves_like "a post"
  let(:foreign_key) { :tweet_id }

  it "requires posted_at" do
    post = build :tweet_post, posted_at: nil

    expect(post).not_to be_valid
    expect(post.errors.keys).to include(:posted_at)
  end
end
