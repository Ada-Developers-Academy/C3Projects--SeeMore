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

   describe "refresh newsfeed" do
     let!(:souly) { create :user, id: 20 }
     let!(:buzz) { create :followee, id: 15 }
     let!(:post) { create :post, followee_id: 15 }
     let!(:post1) { create :post, followee_id: 15 }

     let!(:subby1) { create :subscription, user_id: 20, followee_id: 15 }

     context "finds all the posts" do
       it "redirects" do
         get :refresh
         expect(response).to render_template(:newsfeed)
       end

       it "puts posts in an array" do
        session[:user_id] = souly.id
        @current_user = souly
        post
        get :refresh
        expect(@all_posts).to eq(1)
       end
     end
   end
end
