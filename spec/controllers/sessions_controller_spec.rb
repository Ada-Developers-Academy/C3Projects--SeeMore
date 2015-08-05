require 'rails_helper'

RSpec.describe SessionsController, type: :controller do

  describe "GET #show" do
    it "responds with an HTTP 200 status" do
      get :show
      expect(response).to have_http_status(200)
    end
  end
end
