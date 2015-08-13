require 'rails_helper'
require 'support/vcr_setup'

RSpec.describe TwiSubscriptionsController, type: :controller do
  let(:log_in) {
    @logged_user = create :user
    session[:user_id] = @logged_user.id
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
    it "assigns @response if logged in" do
      VCR.use_cassette('twitter user search') do
        log_in
        get :index, twitter_search: "lolcats"

        expect(assigns(:response)).to_not be_nil
      end
    end
  end

  describe "#create" do
    it "redirects to the home page" do
      VCR.use_cassette('twitter subscription creation') do
        log_in
        post :create, twitter_id: "494335393"

        expect(subject).to redirect_to root_path
        expect(response).to have_http_status(302)
      end
    end

    it "redirects to the home page if not logged in" do
      post :create, twitter_id: "494335393"

      expect(subject).to redirect_to root_path
    end

    #associations method is adding the id to instragram, not twitter
    it "associates the twitter subscription with user" do
      VCR.use_cassette('twitter subscription creation') do
        log_in
        post :create, twitter_id: "494335393"

        expect(assigns(:user).subscriptions).to include(Subscription.find_by(twitter_id: "494335393"))
      end
    end
  end

  describe "twi_subscriptions#refresh_twi" do
    it "creates new posts" do
      VCR.use_cassette('twitter feed refresh') do
        log_in
        twi_sub = (create :twi_sub, twitter_id: "494335393")
        @logged_user.subscriptions << twi_sub
        @logged_user.subscriptions << (create :ig_sub)

        get :refresh_twi
        post = Post.last

        expect(post.subscription.id).to eq twi_sub.id
      end
    end

    it "does not create new posts if not logged in" do
      twi_sub = (create :twi_sub, twitter_id: "494335393")
      get :refresh_twi

      expect(Post.count).to eq 0
    end
  end
end
