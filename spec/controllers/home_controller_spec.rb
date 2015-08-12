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

  # will need to refactor using this setup for VCR use
  # only on tests that would make an API call
  describe "twitter search" do
    it "redirects to twitter results index" do
      VCR.use_cassette('twitter search') do
         get :search, { website: "twitter", search: "tinder" }

         expect(response).to redirect_to twi_subscriptions_path(params: {twitter_search: "tinder"})
         binding.pry
         # expect(@results.first.screen_name).to eq "Tinder"
       end
     end
  end
end
