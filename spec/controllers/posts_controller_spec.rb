require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  describe "GET index" do
    it "requires login" do
      session[:stalker_id] = nil
      get :index

      expect(flash[:error]).to include(:login_required)
      expect(response).to redirect_to(landing_path)
    end
  end
end
