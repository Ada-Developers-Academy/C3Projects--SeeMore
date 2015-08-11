require 'rails_helper'

RSpec.describe TweetPostsController, type: :controller do
  describe "POST #create" do
    context "login required" do
      it "doesn't create TweetPost record" do
        session[:user_id] = nil

        post :create, tweet_post: attributes_for(:tweet_post)
        expect(TweetPost.count).to eq(0)
        expect(flash[:error]).to_not be nil
      end
    end
  end
end
