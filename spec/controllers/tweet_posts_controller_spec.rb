require 'rails_helper'
require 'twit'

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

    context "valid params" do
      before :each do
        # NOT WORKING FOR TWEET POSTS - "Not Authorized."
        VCR.use_cassette 'twitter_posts_response' do
          @user = create :user
          @tweet = create :tweet
          session[:user_id] = @user.id
          post :create
          # NOTE: with VCR, this is no longer using the factory;
          # it's getting an actual tweeter. Is this ok?
        end
      end

      xit "creates an instagram_post record" do
        expect(TweetPost.count).to eq(10)
        expect(TweetPost.first.post_id).to eq("1043242093253047729_1356")
      end

      xit "associates with a Instagram User" do
        expect(TweetPost.first.tweet).to eq(@tweet)
      end

      xit "associates with a User" do
        expect(TweetPost.first.users).to include(@user)
      end

      xit "redirects to root_path" do
        expect(response).to redirect_to(root_path)
        expect(response).to have_http_status(302)
      end
    end

    # ADD INVALID PARAMS
  end
end
