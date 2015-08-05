require 'rails_helper'

RSpec.describe FeedsController, type: :controller do

describe "GET feeds#search" do
  it "loads the search form" do
    get :search
    expect(response).to render_template(:search)
  end
end

describe "POST feeds#search_redirect" do
  context "if search term is present" do
    it "redirects to the results page" do
      search_term = "donald trump"
      post :search_redirect, search_term: search_term
      expect(response).to redirect_to(search_redirect_path)
    end
  end

  context "if search term is not present" do
    it "redirects to the search form" do
      post :search_redirect
      expect(response).to redirect_to(search_path)
    end
  end
end

end
