require 'rails_helper'

RSpec.describe HomeController, type: :controller do

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
        post :twitter_users_redirect, user: "pig"
      end
      it "redirects to twitter_users_path if params[:user]" do
        # expect(response).to have_http_status(302)
        expect(response).to redirect_to(twitter_users_path("pig"))
      end

      # negative test
      it "doesn't redirect to other search term" do
        expect(response).to_not redirect_to(twitter_users_path("cow"))
      end
    end

    it "redirects to search_path if no search term entered" do
      post :twitter_users_redirect, user: nil
      expect(response).to redirect_to(search_path)
    end
  end

end
