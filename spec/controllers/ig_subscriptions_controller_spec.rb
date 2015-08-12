require 'rails_helper'
require 'support/vcr_setup'
require 'pry'

RSpec.describe IgSubscriptionsController, type: :controller do
  let(:log_in) {
    logged_user = create :user
    session[:user_id] = logged_user.id
    session[:access_token] = ENV["INSTAGRAM_ACCESS_TOKEN"]
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
    it "assigns @response if logged in" do
      VCR.use_cassette('instagram assigns response') do
        log_in

        get :index, instagram_search: "lilagrc"


        expect(assigns(:response)).to_not be_nil
      end
    end
  end

  describe "#create" do
    it "redirects to the home page" do
      VCR.use_cassette('instagram #create redirects home') do
        log_in
        post :create, instagram_id: "777"

        expect(subject).to redirect_to root_path
        expect(response).to have_http_status(302)
      end
    end

    it "redirects to the home page if not logged in" do
      post :create, instagram_id: "777"

      expect(subject).to redirect_to root_path
    end

    #associations method is adding the id to instragram, not twitter
    it "associates the twitter subscription with user" do
      VCR.use_cassette('instagram #create associates sub with user') do
        log_in
        post :create, instagram_id: "777"

        expect(assigns(:user).subscriptions).to include(Subscription.find_by(instagram_id: "777"))
      end
    end
  end

  describe "#refresh_ig" do
    it "should create 15 posts when a user has a single subscription & refreshes" do
      VCR.use_cassette('instagram refresh 1') do
        log_in
        user = User.first
        user.subscriptions << (create :ig_sub)
        get :refresh_ig

        expect(Post.count).to eq 15
        expect(user.posts.count).to eq 15
      end
    end

    it "redirect to twitter refresh action" do
      log_in
      get :refresh_ig

      expect(response).to redirect_to refresh_twi_path
    end
  end

  # describe "#single_subscription_httparty_object" do
  #   it "DOES SOEMTHING" do
  #     log_in
  #     subscription = create :ig_sub
  #     testing = IgSubscriptionsController.new
  #
  #     expect(testing.send(:single_subscription_httparty_object, subscription)).to eq HTTParty
  #   end
  # end

  # will need to refactor using this setup for VCR use- only
  # for tests that will hit the API
  # VCR.use_cassette('whatever cassette name you want') do
  #    # the body of the test would go here...
  # end
end
