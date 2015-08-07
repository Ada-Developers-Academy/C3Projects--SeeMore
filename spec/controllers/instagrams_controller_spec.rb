require 'rails_helper'
require 'pry'

RSpec.describe InstagramsController, type: :controller do

  describe "POST #create" do
    context "valid params" do
      before :each do
        @user = create :user
        session[:user_id] = @user.id
        post :create, instagram: attributes_for(:instagram)
      end

      it "creates an instagram record" do
        expect(Instagram.count).to eq(1)
        expect(Instagram.first.username).to eq("Ada")
      end

      it "associates with a user" do
        expect(Instagram.first.user_ids).to include(@user.id)
      end

      it "redirects to root_path" do
        expect(response).to redirect_to(root_path)
        expect(response).to have_http_status(302)
      end


    end

    context "invalid params" do
      # invalid stuff
    end


  end# post create

end# controller
