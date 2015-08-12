require 'rails_helper'
require 'support/vcr_setup'
require 'pry'

RSpec.describe HomeController, type: :controller do
  let(:log_in) {
    @logged_user = create :user
    session[:user_id] = @logged_user.id
  }

  # will need to refactor using this setup for VCR use
  # only on tests that would make an API call
  # VCR.use_cassette('whatever cassette name you want') do
  #    # the body of the test would go here...
  # end
  describe "GET #index" do
    context "when logged in" do
      it "renders the index page" do
        log_in
        get :index

        expect(subject).to render_template :index
        expect(response).to have_http_status(200)
      end

       it "user has access to their posts" do
        log_in
        sub = create(:ig_sub)
        post = create(:post)
        @logged_user.subscriptions << sub

        get :index

        expect(@logged_user.posts).to include post
       end
    end

    context "when not logged in" do
      it "renders the index page" do
        get :index

        expect(subject).to render_template :index
        expect(rendered).to match "You must sign in to feed the beast."
      end
    end
  end

end
