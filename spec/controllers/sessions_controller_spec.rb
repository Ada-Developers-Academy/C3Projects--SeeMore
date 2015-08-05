require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  describe "GET #create" do
    context "when using omniauth developer authorization" do
      context "when successful" do

        before { request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:developer] }

        it "redirects to home page" do
          get :create, provider: :developer

          expect(response).to redirect_to root_path
        end
      end
    end
  end
end
