require 'rails_helper'

RSpec.describe InstagramPost, type: :model do
  it_behaves_like "a post"
  let(:foreign_key) { :instagram_id }

  it "requires an image_url" do
    post = build :instagram_post, image_url: nil

    expect(post).not_to be_valid
    expect(post.errors.keys).to include(:image_url)
  end
end
