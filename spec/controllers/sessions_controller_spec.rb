require 'rails_helper'

RSpec.describe SessionsController, type: :controller do

  describe "GET #show" do
    it "responds with an HTTP 200 status" do
      get :show
      expect(response).to have_http_status(200)
    end
  end


  describe "POST #create" do
    before :each do
      @user = create :user
    end

    let(:good_params){{:session => {username: "MyString"}}}
    let(:bad_params){{:session => {username: "MyStrng"}}}
    
    it "creates a new session" do
      post :create, good_params
      expect(session).to include :username
    end
    
    it "sets :user_id attribute to the user's id" do
      post :create, good_params
      expect(session[:user_id]).to be(@user.id)
    end

    # it "finds the correct user." do
    # end



  end



end

