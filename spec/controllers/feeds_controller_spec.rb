require 'rails_helper'

RSpec.describe FeedsController, type: :controller do
  
  before :each do
    @user = create :user
    session[:user_id] = @user.id
    @instagramer = create :instagram, user_ids: [@user.id]
    @tweeter = create :tweet, user_ids: [@user.id]
    @instagram = create :instagram_post, instagram_id: @instagramer.id
    @tweet = create :tweet_post, tweet_id: @tweeter.id
  end

  describe "GET #people" do
    it "renders people template" do
      get :people

      expect(response).to be_success
      expect(response).to render_template("feeds/people")
    end
  end

  describe "GET #index" do
    it "renders the home page" do
      # @all_posts = [{ig_id: @instagram.id, post_id: @instagram.post_id, image_url: @instagram.image_url}]
      get :index

      expect(response).to be_success
      expect(response).to have_http_status(200)
      expect(response).to render_template("feeds/index")
    end
  end


  ## FROM TWEET POSTS CONTROLLER
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

  ## FROM INSTRAGRAM POSTS
  RSpec.describe InstagramPostsController, type: :controller do
    describe "POST #create" do
      context "login required" do
        it "doesn't create InstagramPost record" do
          session[:user_id] = nil

          post :create, instagram_post: attributes_for(:instagram_post)
          expect(InstagramPost.count).to eq(0)
          expect(flash[:error]).to_not be nil
        end
      end

      context "valid params" do
        before :each do
          VCR.use_cassette 'instagram_posts_response' do
            @user = create :user
            @instagram = create :instagram
            session[:user_id] = @user.id
            session[:access_token] = ENV['INSTAGRAM_ACCESS_TOKEN']
            post :create
            # NOTE: with VCR, this is no longer using the factory;
            # it's getting an actual instagrammer. Is this ok?
          end
        end

        it "creates an instagram_post record" do
          expect(InstagramPost.count).to eq(10)
          expect(InstagramPost.first.post_id).to eq("1043242093253047729_1356")
        end

        it "associates with a Instagram User" do
          expect(InstagramPost.first.instagram).to eq(@instagram)
        end

        it "associates with a User" do
          expect(InstagramPost.first.users).to include(@user)
        end

        it "redirects to root_path" do
          expect(response).to redirect_to(root_path)
          expect(response).to have_http_status(302)
        end
      end

      # ADD INVALID PARAMS

    end
  end

end
