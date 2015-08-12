require 'rails_helper'
require 'support/vcr_setup'
require 'pry'

RSpec.describe HomeController, type: :controller do
  let(:log_in) {
    @logged_user = create :user
    session[:user_id] = @logged_user.id
  }

  describe "GET #index" do
    it "renders the index page" do
      get :index

      expect(subject).to render_template :index
      expect(response).to have_http_status(200)
    end

    context "when logged in" do
      it "user has access to their posts" do
        log_in
        sub = create(:ig_sub)
        post = create(:post)
        @logged_user.subscriptions << sub

        get :index

        expect(@logged_user.posts).to include post
      end
    end
  end

  describe "search form" do
    context "twitter search" do
      it "redirects to twitter results index" do
         get :search, { website: "twitter", search: "tinder" }

         expect(response).to redirect_to twi_subscriptions_path(params: {twitter_search: "tinder"})
      end
    end

    context "instagram search" do
      it "redirects to instragram results index" do
         get :search, { website: "instagram", search: "kittens" }

         expect(response).to redirect_to ig_subscriptions_path(params: {instagram_search: "kittens"})
      end
    end

    context "empty search input" do
      it "redirects to home page if search field empty" do
         get :search, { website: "twitter", search: "" }

         expect(response).to redirect_to root_path
      end
    end

    context "no search input" do
      it "redirects to home page if search from url" do
         get :search

         expect(response).to redirect_to root_path
      end
    end
  end
end
