require 'rails_helper'

RSpec.describe SessionsController, type: :controller do

  describe "GET #create" do
    context "when using instagram authorization" do
      context "is successful" do
        before { request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:instagram] }

        it "redirects to home page" do
          get :create, provider: :instagram
          expect(response).to redirect_to root_path
        end

        it "creates a user" do
          expect { get :create, provider: :instagram }.to change(User, :count).by(1)
        end

        it "assigns the @user variable" do
          get :create, provider: :instagram
          expect(assigns(:user)).to be_an_instance_of User
        end

        it "assigns the session[:user_id]" do
          get :create, provider: :instagram
          expect(session[:user_id]).to eq assigns(:user).id
        end

      end # context is successful

      context "when the user has already signed up" do
        before(:each) do
          request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:instagram]
        end
        let!(:petunia) {
          User.find_or_create_from_omniauth(
            OmniAuth.config.mock_auth[:instagram]
          )
        }

        it "doesn't create another user" do
          petunia
          expect{ get :create, {provider: :instagram} }.to_not change(User, :count).by(1)
        end

        it "assigns the session[:user_id]" do
          get :create, provider: :instagram
          expect(session[:user_id]).to eq petunia.id
        end
      end #context

      context "fails on instagram" do
        before { request.env["omniauth.auth"] = :invalid_credential }

        it "redirect to home with flash error" do
          get :create, provider: :instagram
          expect(response).to redirect_to root_path
          expect(flash[:notice]).to include "Failed to authenticate"
        end
      end # context

      context "when failing to save the user" do
        before {
          request.env["omniauth.auth"] = {"uid" => "1234", "info" => {}}
        }

        it "redirect to home with flash error" do
          get :create, provider: :instagram
          expect(response).to redirect_to root_path
          expect(flash[:notice]).to include "Failed to save the user"
        end
      end # context
    end # using intsagram auth
  end #create describe
end
