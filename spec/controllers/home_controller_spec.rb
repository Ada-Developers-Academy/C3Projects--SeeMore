require 'rails_helper'

RSpec.describe HomeController, type: :controller do
  # before :each do
  #   session[:user_id] = user.id
  # end

  describe "GET #newsfeed" do

    context "user has no subscription" do
      let!(:souly) { create :user, id: 2 }

      before :each do
        get :newsfeed
      end

      it "returns http success" do
        expect(response).to have_http_status(200)
      end

      it "should display a flash error" do
        expect(flash[:errors]).to include("You have no subscriptions! Search users to subscribe to.")
      end
    end

    context "user has subscriptions" do
      let!(:souly) { create :user, id: 20 }
      let!(:buzz) { create :followee, id: 15 }
      let!(:subscription) { create :subscription, followee_id: 15, user_id: 20, created_at: (Time.now - 10) }
      let!(:post) { create :post, followee_id: 15, native_created_at: Time.now + 1 }
      let!(:post1) { create :post, followee_id: 15, native_created_at: Time.now + 1 }

      it "should have @rev_posts" do
        session[:user_id] = souly.id
        get :newsfeed
        expect(assigns[:rev_posts].count).to eq(2)
      end
    end

  end # newsfeed
end # describe
