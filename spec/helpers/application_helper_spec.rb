require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the ApplicationHelper. For example:
#
# describe ApplicationHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe ApplicationHelper, type: :helper do

  before(:each) do
    create :user
    @our_user = User.find(1)
    session[:user_id] = @our_user.id
  end

  context "when you haven't followed a Twitter user yet" do
    it "returns false after a following? check" do
      # If a user has just signed in / signed up and searched for Twitter users
      expect(helper.tw_following?("100")).to be(false)
    end
  end

  context "when you're already following a Twitter user" do
    it "returns true after a following? check" do
      create :tw_user
      twitter_user = TwUser.find(1)
      @our_user.tw_users << [twitter_user]
      expect(helper.tw_following?("100")).to be(true)
    end
  end
end
