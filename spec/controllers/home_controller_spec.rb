require 'rails_helper'

RSpec.describe HomeController, type: :controller do
  # before :each do
  #   session[:user_id] = user.id
  # end

  describe "GET #newsfeed" do
    # let!(:souly) { create :user, id: 20 }
    # let!(:buzz) { create :followee, id: 15 }
    # let!(:post) { create :post, followee_id: 15 }
    # let!(:post1) { create :post, followee_id: 15 }
    # let!(:subscription) { create :subscription, followee_id: 15, user_id: 20 }

    before :each do
      get :newsfeed
    end

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    context "user has no subscription" do
      let!(:souly) { create :user, id: 2 }
      it "should display a flash error" do
        get :newsfeed
        binding.pry
        expect(flash[:errors]).to include("You have no subscriptions! Search users to subscribe to.")
      end
    end

  end # newsfeed
end # describe
