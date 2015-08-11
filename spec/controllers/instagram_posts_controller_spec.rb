require 'rails_helper'

RSpec.describe InstagramPostsController, type: :controller do
  describe "POST #create" do
    context "login required" do
      it "doesn't create InstagramPost record" do
        session[:user_id] = nil

        post :create, instagram_post: attributes_for(:instagram_post)
        expect(InstagramPost.count).to eq(0)
        expect(flash[:error]).to_not be nil
      end
    end

    # context "valid params" do
    #   before :each do
    #     @user = create :user
    #     @instagram = create :instagram
    #     session[:user_id] = @user.id
    #     post :create, instagram_post: attributes_for(:instagram_post)
    #   end
    #
    #   it "creates an instagram_post record" do
    #     expect(InstagramPost.count).to eq(1)
    #     expect(InstagramPost.first.post_id).to eq("555555555")
    #   end
#
    #   it "associates with a Instagram User" do
    #     expect(InstagramPost.first.instagrams).to include(@instagram)
    #   end
    #
    #   it "associates with a User" do
    #     expect(InstagramPost.first.users).to include(@user)
    #   end
    #
    #   it "redirects to root_path" do
    #     expect(response).to redirect_to(root_path)
    #     expect(response).to have_http_status(302)
    #   end
#     end
  
  end
end
