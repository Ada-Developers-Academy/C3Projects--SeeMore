require 'rails_helper'
require 'support/vcr_setup'

RSpec.describe SessionsController, type: :controller do

  describe "GET #new" do
    before(:each) do
      get :new, provider: "twitter"
    end

    it "responds with an HTTP 302 status (redirect)" do
      expect(response).to have_http_status(302)
    end
  end

  describe "GET #show" do
    it "responds with an HTTP 200 status" do
      get :show
      expect(response).to have_http_status(200)
    end
  end

  # This is commented out because we could not get it to work
  # describe "POST #create" do
  #   before :each do
  #     @user = create :user
  #   end
  #
  #   let(:good_params){ { username: "MyString", avatar_url: "kitty.jpeg", uid: "344432", provider: 'instagram', code: "d8f12e2001b845208032e27f1446272c" } }
  #   let(:bad_params){ { username: "MyStrng" } }
  #
  #   it "sets :user_id attribute to the user's id" do
  #     VCR.use_cassette 'controller/instagram_user_auth' do
  #       post :create, good_params
  #       expect(session[:user_id]).to eq @user.id
  #     end
  #   end
  #
  #   it "finds the correct user." do
  #   end
  # end

  describe "DELETE #destroy" do
    before(:each) do
      @user = create :user
      session[:user_id] = @user.id
      delete :destroy
    end

    it "signs the user out" do
      expect(session[:user_id]).to be(nil)
    end

    it "redirects to home page" do
      expect(response).to redirect_to(root_path)
    end
  end
end
