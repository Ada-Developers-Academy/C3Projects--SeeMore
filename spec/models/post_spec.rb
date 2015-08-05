require 'rails_helper'

RSpec.describe Post, type: :model do
  before :each do
    @post = create :post
  end

  it "creates a new post" do
    expect(@post).to be_valid
  end
end
