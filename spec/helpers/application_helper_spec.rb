require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do

  describe "following a Twitter user" do
    before(:each) do
      create :user
      @our_user = User.find(1)
      session[:user_id] = @our_user.id
      params[:provider] = "twitter"
    end

    context "when you haven't followed a Twitter user yet" do
      it "returns false after a following? check" do
        # If a user has just signed in / signed up and searched for Twitter users
        expect(helper.following?("100")).to be(false)
      end
    end

    context "when you're already following a Twitter user" do
      it "returns true after a following? check" do
        twitter_user = create :tw_user
        @our_user.tw_users << [twitter_user]
        expect(helper.following?("100")).to be(true)
      end
    end
  end

  describe "following an Instagram user" do
    before(:each) do
      @our_user = create :user
      session[:user_id] = @our_user.id
      params[:provider] = "instagram"
    end

    context "when you haven't followed an Instagram user yet" do
      it "returns false after a following? check" do
        # If a user has just signed in / signed up and searched for Twitter users
        expect(helper.following?("12345678")).to be(false)
      end
    end

    context "when you're already following an Instagram user" do
      it "returns true after a following? check" do
        instagram_user = create :instagram_user
        @our_user.instagram_users << [instagram_user]
        expect(helper.following?("12345678")).to be(true)
      end
    end
  end

  it "finds a TwUser by the tw_user_id" do
    tw_user = create :tw_user
    tweet = create :tweet
    expect(helper.tw_user_lookup(tweet)).to eq(tw_user)
  end

  it "makes a datetime easier to read" do
    tweet = create :tweet
    time = tweet.created_time
    expect(helper.tw_prettify(time)).to eq("Thu Aug  6 15:07:59 2015")
  end

  context "there is a logged in user" do
    it "finds the logged in users username" do
      user = create :user
      session[:user_id] = user.id
      expect(helper.user_or_guest).to eq(user.username)
    end
  end

  context "there is not a logged in user" do
    it "uses 'guest' as the user's name" do
      expect(helper.user_or_guest).to eq("guest")
    end
  end
end
