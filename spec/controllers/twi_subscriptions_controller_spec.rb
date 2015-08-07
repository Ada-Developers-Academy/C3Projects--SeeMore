require 'rails_helper'

RSpec.describe TwiSubscriptionsController, type: :controller do

  describe "#index" do

    it "renders the index page" do
      get :index

      expect(subject).to render_template :index
      expect(response).to have_http_status(200)
    end
  end

  describe "#create" do

    it "redirects to the home page" do
      post :create

      expect(subject).to redirect_to root_path
      expect(response).to have_http_status(302)
    end
  end


end
