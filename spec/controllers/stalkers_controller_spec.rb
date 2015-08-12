require 'rails_helper'

RSpec.describe StalkersController, type: :controller do
  describe "GET index " do
    it "redirects to landing_path if no user id is present" do
      get :index, stalker_id: 3
      expect(response).to redirect_to(landing_path)
    end

    before { request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:twitter]}
    let!(:stalker) {Stalker.find_or_create_from_auth_hash(OmniAuth.config.mock_auth[:twitter])}
    it "renders the dashboard_path if user is logged in via twitter" do
     session[:stalker_id] = 1
      get :index, stalker_id: 1
      expect(response).to render_template :index
    end


    before { request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:instagram]}
    let!(:stalker) {Stalker.find_or_create_from_auth_hash(OmniAuth.config.mock_auth[:instagram])}
    it "renders the dashboard_path if user is logged in via instagram" do
     session[:stalker_id] = 1
      get :index, stalker_id: 1
      expect(response).to render_template :index
    end


  before { request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:vimeo]}
  let!(:stalker) {Stalker.find_or_create_from_auth_hash(OmniAuth.config.mock_auth[:vimeo])}
  it "renders the dashboard_path if user is logged in via vimeo" do
   session[:stalker_id] = 1
    get :index, stalker_id: 1
    expect(response).to render_template :index
  end
end
end
