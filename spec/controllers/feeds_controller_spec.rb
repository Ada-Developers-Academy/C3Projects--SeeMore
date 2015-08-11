require 'rails_helper'
require 'support/vcr_setup'

RSpec.describe FeedsController, type: :controller do

  describe "GET feeds#search" do
    it "loads the search form" do
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
        search_term = "donald trump"
        post :search_redirect, search_term: search_term
        expect(response).to redirect_to(search_results_path(search_term))
      end
    end

    context "if search term is not present" do
      it "redirects to the search form" do
        post :search_redirect, params_no_search
        expect(response).to redirect_to(search_path('instagram'))
      end
    end
  end

  describe "GET feeds#search_results" do
    let(:twitter_params){ { provider: 'twitter', search_term: 'donald trump' } }
  #   let(:instagram_params){ { provider: 'instagram', search_term: 'baby' } }
  #
  #   it "queries the correct API" do
  #     VCR.use_cassette 'controller/twitter_api_response' do
  #       get :search_results, twitter_params
  #       expect(assigns(:results).first.id).to eq(25073877)
  #     end
  #
  #     VCR.use_cassette 'controller/instagram_api_search' do
  #       get :search_results, instagram_params
  #       expect(assigns(:results).first.id).to eq("1105876259")
  #     end
  #   end

    it "receives a response from the twitter api" do
      VCR.use_cassette 'controller/twitter_api_response' do
        get :search_results, twitter_params
        expect(assigns(:results).first.id).to eq(25073877)
      end
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

  describe "#ig_follow" do
    let(:user){create :user}
    let(:instagram_user){create :instagram_user}

    it "creates an association between user and IG account"do
    end
  end
end
