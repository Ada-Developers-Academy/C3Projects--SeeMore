require 'rails_helper'

RSpec.describe FolloweesController, type: :controller do
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
        post :twitter_users_redirect, user: "pig", source: "twitter"
      end

      it "redirects to search_results_path if params[:user]" do
        # expect(response).to have_http_status(302)
        expect(response).to redirect_to(search_results_path("twitter", "pig"))
      end

      # negative test
      it "doesn't redirect to other search term" do
        expect(response).to_not redirect_to(search_results_path("twitter", "cow"))
      end
    end

    context "no search term entered" do
      it "without a user it redirects to search_path" do
        post :twitter_users_redirect, source: "twitter",  user: nil
        expect(response).to redirect_to(search_path)
      end
    end
  end

  describe "GET #search_results" do
    it "renders the search template" do
      get :search_results, source: "twitter", user: "cow"
      expect(response).to render_template("search")
    end
  end
end
