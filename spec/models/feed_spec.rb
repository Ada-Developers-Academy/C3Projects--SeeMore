require 'rails_helper'

RSpec.describe Feed, type: :model do
  before :each do
    @feed = create :feed
  end

  it "creates a new feed" do
    expect(@feed).to be_valid
  end
end
