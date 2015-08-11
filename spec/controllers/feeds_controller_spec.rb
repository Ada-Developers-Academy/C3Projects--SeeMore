require 'rails_helper'

RSpec.describe FeedsController, type: :controller do
  before :each do 
    @user = create :user
    session[:user_id] = @user.id
    @instagrammer = create :instagram
    @tweeter = create :tweet
  end

  describe "GET #people" do
    context "logged in user" do
      it "renders people template" do
        get :people
        expect(response).to render_template("feeds/people")
      end
    end
  end

  describe "GET #index" do
    context "people feed display" do
      xit "renders the home page" do
        get :index

        expect(response).to be_success
        expect(response).to have_http_status(200)
      end
    end
  end

end
