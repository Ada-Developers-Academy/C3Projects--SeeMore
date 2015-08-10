require 'rails_helper'
require 'support/vcr_setup'


RSpec.describe TwiSubscriptionsController, type: :controller do
  let(:log_in) {
    logged_user = create :user
    session[:user_id] = logged_user.id
  }

  describe "#index" do
    it "renders the index page" do
      log_in
      get :index

      expect(subject).to render_template :index
      expect(response).to have_http_status(200)
    end

    it "redirect to home page if not logged in" do
      get :index

      expect(subject).to redirect_to root_path
    end

    # will need to refactor using this setup for VCR use
    # only needed for tests that hit the API
    it "assigns @results if logged in" do
      VCR.use_cassette('twitter user search') do
        log_in

        get :index, twitter_search: "lolcats"

        expect(assigns(:results)).to_not be_nil
      end
    end


  end

  describe "#create" do
    it "redirects to the home page" do
      log_in
      post :create, twitter_id: "777"

      expect(subject).to redirect_to root_path
      expect(response).to have_http_status(302)
    end

    it "redirects to the home page if not logged in" do
      post :create, twitter_id: "777"

      expect(subject).to redirect_to root_path
    end

    #associations method is adding the id to instragram, not twitter
    it "associates the twitter subscription with user" do
      log_in
      post :create, twitter_id: "777"

      expect(assigns(:user).subscriptions).to include(Subscription.find_by(twitter_id: "777"))
    end
  end
end
