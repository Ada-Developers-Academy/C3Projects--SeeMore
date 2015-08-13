require 'rails_helper'
require 'support/vcr_setup'

RSpec.describe FeedsController, type: :controller do

  describe "GET index" do
    before :each do
      user = create :user
      session[:user_id] = user.id
      get :index
    end

    it "responds successfully" do
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it "renders the index view" do
      expect(response).to render_template(:index)
    end
  end

  describe "GET feeds#search" do
    it "loads the search form" do
      user = create :user
      session[:user_id] = user.id
      get :search, provider: 'instagram'
      expect(response).to render_template(:search)
    end
  end

  describe "POST feeds#search_redirect" do
    let(:params){ { provider: 'instagram', search_term: 'baby' } }
    let(:params_no_search){ { provider: 'instagram' } }

    it "receives the API provider from the search form" do
      post :search_redirect, params
      expect(params[:provider]).to eq 'instagram'
    end

    context "if search term is present" do
      it "redirects to the results page" do
        user = create :user
        session[:user_id] = user.id
        search_term = "donald trump"
        post :search_redirect, search_term: search_term
        expect(response).to redirect_to(search_results_path(search_term))
      end
    end

    context "if search term is not present" do
      it "redirects to the search form" do
        user = create :user
        session[:user_id] = user.id
        post :search_redirect, params_no_search
        expect(response).to redirect_to(search_path('instagram'))
      end
    end
  end

  describe "GET feeds#search_results" do
    let(:twitter_params){ { provider: 'twitter', search_term: 'donald trump' } }
    let(:instagram_params){ { provider: 'instagram', search_term: 'baby' } }
    let(:unknown_provider){ { provider: 'github', search_term: 'beyonce' } }

    before :each do
      user = create :user
      session[:user_id] = user.id
    end

    it "queries the correct API" do
      VCR.use_cassette 'controller/twitter_api_response' do
        get :search_results, twitter_params
        expect(assigns(:results).first.id).to eq(25073877)
      end

      VCR.use_cassette 'controller/instagram_api_search' do
        get :search_results, instagram_params
        expect(assigns(:results).first.id).to eq("1105876259")
      end
    end

    it "receives a response from the twitter api" do
      VCR.use_cassette 'controller/twitter_api_response' do
        get :search_results, twitter_params
        expect(assigns(:results).first.id).to eq(25073877)
      end
    end

    it "redirects to the search page if given an unknown :provider" do
      get :search_results, unknown_provider
      expect(subject).to redirect_to search_path(unknown_provider[:provider])
    end
  end

  describe "POST #tw_follow" do
    before(:each) do
      request.env["HTTP_REFERER"] = "/"
      @user = create :user
      @twitter_user = create :tw_user
      session[:user_id] = @user.id
    end

    it "follows a twitter user" do
      post :tw_follow, tw_user: @twitter_user.tw_user_id_str
      expect(@user.tw_users).to include(@twitter_user)
    end

    it "has a user name attribute" do
      post :tw_follow, tw_user: @twitter_user.tw_user_id_str, user_name: 'beyonce'
      @twitter_user.reload
      expect(@twitter_user.user_name).to eq('beyonce')
    end

    it "has a profile image attribute" do
      post :tw_follow, tw_user: @twitter_user.tw_user_id_str, profile_image_url: 'http://fakeurl.org/fancy.jpg'
      @twitter_user.reload
      expect(@twitter_user.profile_image_url).to eq('http://fakeurl.org/fancy.jpg')
    end

    it "has a screen name attribute" do
      post :tw_follow, tw_user: @twitter_user.tw_user_id_str, screen_name: 'queen_beyonce'
      @twitter_user.reload
      expect(@twitter_user.screen_name).to eq('queen_beyonce')
    end
  end

  describe "POST #ig_follow" do
    it "follows an instagram user" do
      request.env["HTTP_REFERER"] = "/"
      user = create :user
      instagram_user = attributes_for(:instagram_user)
      session[:user_id] = user.id

      post :ig_follow, instagram_user
      expect(user.instagram_users).to eq(InstagramUser.where(username: "Talking Rain"))
    end
  end

  describe "GET #dismiss_alert" do
    before :each do
      user = create :user
      session[:alert_msg] = true
      session[:user_id] = user.id
    end

    it "sets session[:alert_msg] to false" do
      request.env["HTTP_REFERER"] = "/feeds"
      get :dismiss_alert

      expect(session[:alert_msg]).to be false
    end

    it "redirects back to the user's last page" do
      request.env["HTTP_REFERER"] = "/feeds"
      post :dismiss_alert

      expect(subject).to redirect_to feeds_path
    end
  end
end
