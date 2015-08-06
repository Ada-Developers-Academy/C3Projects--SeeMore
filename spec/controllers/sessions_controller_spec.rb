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
      expect(response).to have_http_status(:success)
    end
  end

  describe "#create_vimeo" do
    it "returns http success" do
      get :create_vimeo
      expect(response).to have_http_status(:success)
    end
  end

end
