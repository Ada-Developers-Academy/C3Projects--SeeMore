require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  describe "GET #create" do
    context "when using developer strategies" do

    end

    context "when using twitter authentication" do
      context "is successful" do
        before { request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:twitter] }

        it "redirects to the homepage" do
          get :create, provider: :twitter

          expect(response).to redirect_to root_path
        end

        it "creates a user" do
           expect { get :create, provider: :twitter }.to change(Stalker, :count).by(1)
        end

        it "assigns session[:user_id]" do
          get :create, provider: :twitter
          expect(assigns(:user)).to be_an_instance_of Stalker
        end
      end

      context "user already exists" do
        before(:each) do
          request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:twitter]
          get :create, provider: :twitter
        end
        # before { request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:twitter] }
        let(:user) { Stalker.find_or_create_from_auth_hash(OmniAuth.config.mock_auth[:twitter]) }

        it "doesn't create a new user" do
          get :create, provider: :twitter

          expect(Stalker.count).to eq 1
        end

        it "assigns session[:user_id]" do
          get :create, provider: :twitter

          expect(session[:user_id]).to eq user.id
        end
      end

      context "when failing to save the user" do
        let(:invalid_params) { {
          "provider" => "twitter",
          "uid" => "1234",
          "info" => { "nickname" => nil}
          }
        }
        before { request.env["omniauth.auth"] = invalid_params }

       it "redirects to home with flash error" do
         get :create, provider: :twitter

         expect(response).to redirect_to root_path
         expect(flash[:error]).to_not be nil
       end
      end
    end

    context "when using vimeo authentication" do

    end

    context "when using instagram authentication" do

    end
  end

end
