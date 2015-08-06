require 'rails_helper'

RSpec.describe User, type: :model do
  before :each do
    @user = create :user
  end

  it "creates a new user" do
    expect(@user).to be_valid
  end
end
