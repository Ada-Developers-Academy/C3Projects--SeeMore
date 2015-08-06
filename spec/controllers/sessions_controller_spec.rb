require 'rails_helper'

RSpec.describe SessionsController, type: :controller do

  describe "GET #create" do
    it "returns http success" do
     
      get :create

      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #destroy" do
    it "returns http success" do
      delete :destroy
      expect(response).to have_http_status(302)
    end
  end

  describe "#create_vimeo" do
    let(:user) { AuUser.find_or_create_by(OmniAuth.config.mock_auth[:vimeo])}
    it "returns http success" do
      session[:user_id] = user.id
      get :create_vimeo
      expect(response).to have_http_status(:success)
    end
  end

end
