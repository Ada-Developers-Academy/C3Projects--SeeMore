require 'rails_helper'
require 'support/vcr_setup'

RSpec.describe IgSubscriptionsController, type: :controller do
  let(:log_in) {
    logged_user = create :user
    session[:user_id] = logged_user.id
    session[:access_token] = "1234454433"
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

    #how to test this without using actual access token????
    it "assigns @results if logged in" do
      log_in

      get :index, instagram_search: "lilagrc"

      expect(assigns(:results)).to_not be_nil
    end
  end

  describe "#create" do
    it "redirects to the home page" do
      log_in
      post :create, instagram_id: "777"

      expect(subject).to redirect_to root_path
      expect(response).to have_http_status(302)
    end

    it "redirects to the home page if not logged in" do
      post :create, instagram_id: "777"

      expect(subject).to redirect_to root_path
    end

    #associations method is adding the id to instragram, not twitter
    it "associates the twitter subscription with user" do
      log_in
      post :create, instagram_id: "777"

      expect(assigns(:user).subscriptions).to include(Subscription.find_by(instagram_id: "777"))
    end
  end

  # will need to refactor using this setup for VCR use- only
  # for tests that will hit the API
  # VCR.use_cassette('whatever cassette name you want') do
  #    # the body of the test would go here...
  # end
end
