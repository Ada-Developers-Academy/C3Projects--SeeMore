require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  describe "GET #create" do
    context "logging in via instagram - valid params" do
      before :each do
        request.env['omniauth.auth'] = OmniAuth.config.mock_auth[:instagram]
      end

      it "redirects to root_path" do
        get :create, provider: :instagram

        expect(response).to redirect_to root_path
      end

      it "creates a user" do
        expect {
          get :create, provider: :instagram
          }.to change(User, :count).by(1)
      end

      it "sets user_id and access token" do
        get :create, provider: :instagram
        expect(session[:user_id]).to eq(1)
        expect(session[:access_token]).to eq("token")
      end
    end

    context "logging in via instagram - invalid params" do
      let(:invalid_params) { {
        :provider => 'instagram',
        :uid => '12345',
        info: {email: "a@b.com", name: "Ada"},
        credentials: { token: 'token' }
      } }

      before :each do
        request.env['omniauth.auth'] = OmniAuth.config.mock_auth[:instagram]
      end

      it "does not create a user" do
        get :create, invalid_params

        expect {
          get :create, invalid_params
          }.to change(User, :count).by(0)
      end

    end
  end

  # describe "POST #create" do
  #   context "valid params" do
  #     before :each do
  #       @user = create :user
  #       session[:user_id] = @user.id
  #       post :create, tweet: attributes_for(:tweet)
  #     end

  #     it "creates a twitter record" do
  #       expect(Tweet.count).to eq(1)
  #       expect(Tweet.first.username).to eq("Ada")
  #     end

  #     it "associates with a user" do
  #       expect(Tweet.first.user_ids).to include(@user.id)
  #     end

  #     it "redirects to root_path" do
  #       expect(response).to redirect_to(root_path)
  #       expect(response).to have_http_status(302)
  #     end
  #   end
  # end

  # describe "DELETE #destroy" do
  #   context "valid params" do
  #     before :each do
  #       @user = create :user
  #       session[:user_id] = @user.id
  #       post :create, tweet: attributes_for(:tweet)
  #     end

  #     it "creates a twitter record" do
  #       expect(Tweet.count).to eq(1)
  #       expect(Tweet.first.username).to eq("Ada")
  #     end

  #     it "associates with a user" do
  #       expect(Tweet.first.user_ids).to include(@user.id)
  #     end

  #     it "redirects to root_path" do
  #       expect(response).to redirect_to(root_path)
  #       expect(response).to have_http_status(302)
  #     end
  #   end
  # end

end
