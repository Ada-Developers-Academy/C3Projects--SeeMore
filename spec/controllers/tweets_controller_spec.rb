require 'rails_helper'

RSpec.describe TweetsController, type: :controller do
  describe "POST #create" do
    context "valid params" do
      before :each do
        @user = create :user
        session[:user_id] = @user.id
        post :create, tweet: attributes_for(:tweet)
      end

      it "creates a twitter record" do
        expect(Tweet.count).to eq(1)
        expect(Tweet.first.username).to eq("Ada")
      end

      it "associates with a user" do
        expect(Tweet.first.user_ids).to include(@user.id)
      end

      it "redirects to root_path" do
        expect(response).to redirect_to(root_path)
        expect(response).to have_http_status(302)
      end
    end

    context "invalid params" do
      before :each do
        user = create :user
        session[:user_id] = user.id
        post :create, tweet: attributes_for(:tweet, username: nil)
      end

      it "invalid attributes fail validations" do
        bad_tweet_record = Tweet.create(attributes_for(:tweet, username: nil, user_ids: [1]))
        expect(bad_tweet_record).to_not be_valid
        expect(bad_tweet_record.errors).to include(:username)
      end

      it "does not create a tweet record" do
        expect(Tweet.count).to eq 0
      end

      it "renders the feeds/search view" do
        expect(response).to render_template("feeds/search")
      end
    end
  end
end
