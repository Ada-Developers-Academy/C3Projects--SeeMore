require 'rails_helper'

RSpec.describe HomeController, type: :controller do
  let(:user) { create :user }
  before :each do
    session[:user_id] = user.id
  end

  describe "GET #newsfeed" do

    before :each do
      get :newsfeed
    end

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    # it "finds the current user" do
    #   binding.pry
    #   expect(@current_user).to eq user
    # end

    # it "doesn't find the current user if none set" do
    #   session[:user_id] = nil
    #   expect(@current_user).to be_nil
    # end
  end

   describe "GET #refresh" do
     context "renders newsfeed template" do
       it "redirects" do
         get :refresh
         expect(response).to render_template(:newsfeed)
       end
     end
   end # refresh

   describe "#find_subscription_posts" do
     let!(:souly) { create :user, id: 20 }
     let!(:buzz) { create :followee, id: 15 }
     let!(:post) { create :post, followee_id: 15 }
     let!(:post1) { create :post, followee_id: 15 }

     it "finds all user's subscription posts" do
      session[:user_id] = souly.id
      @current_user = souly
      post
      get :refresh
      expect(@all_posts).to eq(1)
     end
   end
end # describe
