require 'rails_helper'
require 'twit'


RSpec.describe TweetsController, type: :controller do
  describe "POST #search" do
    context "valid params" do
      before :each do
        VCR.use_cassette 'twitter_response' do
          post :search, tweet: { username: "acmei" }
        end
      end

      it 'searches users in Twitter API' do
        expect(assigns(:users).first["username"]).to eq("acmei")
      end

      it "renders search template" do
        expect(response).to render_template("feeds/search")
      end
    end

    context "invalid params" do
      before :each do
        VCR.use_cassette 'twitter_response' do
          post :search, tweet: { username: nil }
        end
      end

      it "redirects to search page" do
        expect(response).to redirect_to("feeds/search")
      end

      it "displays an error message" do
        expect(flash[:error]).to_not be nil
      end
    end
  end # POST #search

  describe "POST #create" do
    context "login required" do
      it "doesn't create twitter record" do
        session[:user_id] = nil

        post :create, tweet: attributes_for(:tweet)
        expect(Tweet.count).to eq(0)
        expect(flash[:error]).to_not be nil
      end
    end

    context "valid params" do
      before :each do
        @user = create :user
        session[:user_id] = @user.id
        post :create, tweet: attributes_for(:tweet)
      end

      it "creates a twitter record" do
        expect(Tweet.count).to eq(1)
        expect(Tweet.first.username).to eq("adaninjaparty")
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

  describe "DELETE #destroy" do
    context "valid params" do
      before :each do
        @user = create :user
        session[:user_id] = @user.id
        @tweeter = create :tweet
      end

      it "unfollows a tweeter" do
        delete :destroy, id: @tweeter.id

        expect(@user.tweets.count).to eq(0)
      end

      it "redirects to the people page" do
        delete :destroy, id: @tweeter.id
        expect(subject).to redirect_to(people_path)
      end
    end
  end # DELETE #destroy

end
