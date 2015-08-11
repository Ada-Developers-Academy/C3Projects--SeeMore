require 'rails_helper'
require 'support/vcr_setup'

RSpec.describe FolloweesController, type: :controller do
  let(:user) { create :user }

  before :each do
    session[:user_id] = user.id
  end

  describe "GET #search" do
    before :each do
      get :search
    end

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    it "renders the search template" do
      expect(response).to render_template("search")
    end
  end

  describe "POST #twitter_users_redirect" do
    context "search term entered" do

      before :each do
        response = post :twitter_users_redirect, user: "pig", source: "twitter"
      end

      it "redirects to search_results_path if params[:user]" do
        expect(response).to redirect_to(search_results_path("twitter", "pig"))
      end

      # negative test
      it "doesn't redirect to other search term" do
        expect(response).to_not redirect_to(search_results_path("twitter", "cow"))
      end

      # negative test
      it "doesn't redirect to instagram search" do
        expect(response).to_not redirect_to(search_results_path("instagram", "pig"))
      end
    end

    context "no search term entered" do
      it "without a user it redirects to search_path" do
        post :twitter_users_redirect, source: "twitter",  user: nil
        expect(response).to redirect_to(search_path)
      end
    end
  end

  describe "POST #instagram_users_redirect" do
    context "search term entered" do
      before :each do
        response = post :instagram_users_redirect, user: "obama", source: "instagram"
      end

      it "redirects to search_results_path if params[:user]" do
        expect(response).to redirect_to(search_results_path("instagram", "obama"))
      end

      # negative test
      it "doesn't redirect to other search term" do
        expect(response).to_not redirect_to(search_results_path("instagram", "bush"))
      end

      # negative test
      it "doesn't redirect to twitter search" do
        expect(response).to_not redirect_to(search_results_path("twitter", "obama"))
      end
    end

    context "no search term entered" do
      it "without a user it redirects to search_path" do
        post :instagram_users_redirect, source: "instagram",  user: nil
        expect(response).to redirect_to(search_path)
      end
    end
  end

  describe "GET #search_results" do
    context "twitter search" do
      it "renders the search template" do
        VCR.use_cassette 'controller/followees_controller/search_results_twitter' do
          response = get :search_results, source: "twitter", user: "cow"
          expect(response).to render_template("search")
        end
      end
    end

    context "instagram search" do
      it "renders the search template" do
        VCR.use_cassette 'controller/followees_controller/search_results_instagram' do
          response = get :search_results, source: "instagram", user: "pig"
          expect(response).to render_template("search")
        end
      end
    end
  end
end
