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
     let(:post) { create :post }
     context "finds all the posts" do
       it "redirects" do
         patch :refresh
         expect(response).to render_template(:newsfeed)
       end
     end
   end
end
