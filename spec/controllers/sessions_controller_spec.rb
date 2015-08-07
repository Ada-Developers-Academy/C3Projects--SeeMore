require 'rails_helper'

RSpec.describe SessionsController, type: :controller do

  describe "GET #destroy" do
    it "returns http success" do
      delete :destroy
      expect(response).to have_http_status(302)
    end
  end


  describe "GET #create_vimeo" do
    context "when using vimeo authorization" do
      context "is successful" do
        # let(:params) {au_user: { provider: :vimeo, uid: 12345} }
        before { request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:vimeo] }

        it "redirects to home page" do
          get :create_vimeo, ({provider: :vimeo, uid: 1234})
          expect(response).to have_http_status(302)
        end

        it "creates a user" do
          expect { get :create_vimeo }.to change(AuUser, :count).by(1)
        end

        it "assigns the @user var" do
          get :create_vimeo, provider: :vimeos
          expect(AuUser.first).to be_an_instance_of AuUser
        end

        it "assigns the session[:user_id]" do
          get :create_vimeo, provider: :vimeo
         
          expect(session[:user_id]).to eq (AuUser.first).id
        end
      end
    end
  end

end
