require 'rails_helper'
require 'twit'

RSpec.describe FeedsController, type: :controller do
  context "not using API" do
    before :each do
      @user = create :user
      session[:user_id] = @user.id
      @instagrammer = create :instagram
      @tweeter = create :tweet
    end

    describe "GET #people" do
      context "logged in user" do
        it "renders people template" do
          get :people
          expect(response).to render_template("feeds/people")
        end
      end
    end

    describe "GET #index" do
      context "people feed display" do
        xit "renders the home page" do
          get :index

          expect(response).to be_success
          expect(response).to have_http_status(200)
        end
      end
    end
  end

  ## FROM TWEET POSTS
  context "Tweet Posts" do
    describe "POST #tweet_post_create" do
      context "not logged in" do
        it "doesn't create InstagramPost record" do
          session[:user_id] = nil

          get :index, tweet_post: attributes_for(:tweet_post)
          expect(TweetPost.count).to eq(0)
        end
      end

      context "valid params" do
        before :each do
          VCR.use_cassette 'twitter_posts_response' do
            @user = create :user
            @tweet = create :tweet
            session[:user_id] = @user.id
            get :index
            # NOTE: with VCR, this is no longer using the factory;
            # it's getting an actual tweeter. Is this ok?
          end
        end

        it "creates tweet_post records" do
          expect(TweetPost.count).to eq(3)
          expect(TweetPost.first.post_id).to eq("629361731651940352")
        end

        it "associates with a Twitter User" do
          expect(TweetPost.first.tweet).to eq(@tweet)
        end

        it "associates with a User" do
          expect(TweetPost.first.users).to include(@user)
        end
      end

      # ADD INVALID PARAMS
    end
  end

  ## FROM INSTRAGRAM POSTS
  context "Instagram Posts from API" do
    describe "POST #instagram_post_create" do
      context "not logged in" do
        it "doesn't create InstagramPost record" do
          session[:user_id] = nil

          get :index, instagram_post: attributes_for(:instagram_post)
          expect(InstagramPost.count).to eq(0)
        end
      end

      context "valid params" do
        before :each do
          VCR.use_cassette 'instagram_posts_response' do
            @user = create :user
            @instagrammer = create :instagram
            session[:user_id] = @user.id
            session[:access_token] = ENV['INSTAGRAM_ACCESS_TOKEN']
            get :index
            # NOTE: with VCR, this is no longer using the factory;
            # it's getting an actual instagrammer. Is this ok?
          end
        end

        it "creates instagram_post record" do
          expect(InstagramPost.count).to eq(15)
          expect(InstagramPost.first.post_id).to eq("1043242093253047729_1356")
        end

        it "associates with a Instagram User" do
          expect(InstagramPost.first.instagram).to eq(@instagrammer)
        end

        it "associates with a User" do
          expect(InstagramPost.first.users).to include(@user)
        end
      end

      # ADD INVALID PARAMS

    end
  end

end
