require 'rails_helper'

#do we get rid of or par down tests for developer log in? since it's not production?
RSpec.describe SessionsController, type: :controller do
  describe "GET #create" do
    context "when using omniauth developer authorization" do
      context "when successful" do

        before { request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:developer] }

        it "redirects to home page" do
          get :create, provider: :developer

          expect(response).to redirect_to root_path
        end

        it "creates a user" do
          expect { get :create, provider: :developer}.to change(User, :count).by(1)
        end

        it "assigns the session[:user_id]" do
          get :create, provider: :developer

          expect(session[:user_id]).to eq assigns(:user).id
        end
      end

    context "when using instagram authorization" do
      context "when successful" do

        before { request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:instagram] }

        it "redirects to home page" do
          get :create, provider: :instagram

          expect(response).to redirect_to root_path
        end

        it "creates a user" do
          expect { get :create, provider: :instagram}.to change(User, :count).by(1)
        end

        it "assigns the session[:user_id]" do
          get :create, provider: :instagram

          expect(session[:user_id]).to eq assigns(:user).id
        end
      end
    end

      context "when the user has already signed in through developer" do

        before { request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:developer] }

        let(:user) { User.find_or_create_user(OmniAuth.config.mock_auth[:developer]) }

        it "doesn't create another user" do
          get :create, provider: :developer

          expect(User.count).to eq(1)
        end

        it "assigns the session[:user_id]" do
          get :create, provider: :developer
          expect(session[:user_id]).to eq user.id
        end
      end

      context "when the user has already signed in with instagram" do

        before { request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:instagram] }

        let(:user) { User.find_or_create_user(OmniAuth.config.mock_auth[:instagram]) }

        it "doesn't create another user" do
          get :create, provider: :instagram

          expect(User.count).to eq(1)
        end

        it "assigns the session[:user_id]" do
          get :create, provider: :instagram
          expect(session[:user_id]).to eq user.id
        end
      end

      context "fails to authenticate developer" do
        before { request.env["omniauth.auth"] = :invalid_credential }

        it "redirect to home with flash error" do
          get :create, provider: :developer

          expect(response).to redirect_to root_path
          expect(flash[:error]).to include "Failed to authenticate"
        end
      end

      context "fails to authenticate instagram user" do
        before { request.env["omniauth.auth"] = :invalid_credential }

        it "redirect to home with flash error" do
          get :create, provider: :instagram

          expect(response).to redirect_to root_path
          expect(flash[:error]).to include "Failed to authenticate"
        end
      end

      context "when failing to save the dev user" do
        before {
          request.env["omniauth.auth"] = { "uid" => nil, "info" => {} }
        }

        it "redirect to home with flash error" do
          get :create, provider: :developer

          expect(response).to redirect_to root_path
          expect(flash[:error]).to include "Failed to authenticate"
        end
      end

      context "when failing to save the instagram user" do
        before {
          request.env["omniauth.auth"] = { "uid" => nil, "info" => {} }
        }

        it "redirect to home with flash error" do
          get :create, provider: :instagram

          expect(response).to redirect_to root_path
          expect(flash[:error]).to include "Failed to authenticate"
        end
      end
    end
  end


  describe "DELETE #destroy" do
    before { request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:instagram] }

    let(:user) { User.find_or_create_user(OmniAuth.config.mock_auth[:instagram]) }

    it "destroys a session id" do
      delete :destroy, provider: :instagram

      expect(session[:user_id]).to eq nil
    end

    it "removes association between session[:user_id] and user.id" do

      delete :destroy, provider: :instagram

      expect(session[:user_id]).to_not eq user.id
    end
  end
end
