require 'rails_helper'

RSpec.describe HomeController, type: :controller do
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

  describe "GET #newsfeed" do

    before :each do
      get :newsfeed
    end

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    # it "finds the current user" do
    #   binding.pry
    #   expect(@current_user).to eq user
    # end

    # it "doesn't find the current user if none set" do
    #   session[:user_id] = nil
    #   expect(@current_user).to be_nil
    # end
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

    context "no search term entered" do
      it "redirects to search_path" do
        post :twitter_users_redirect, user: nil
        expect(response).to redirect_to(search_path)
      end
    end
  end

  describe "GET #twitter_users" do
    it "renders the twitter users template" do
      get :twitter_users, user: "cow"
      expect(response).to render_template("twitter_users")
    end
  end
end
