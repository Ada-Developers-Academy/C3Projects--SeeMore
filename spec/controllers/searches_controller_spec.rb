require 'rails_helper'

RSpec.describe SearchesController, type: :controller do
  let (:invalid_search) { "" }
  let (:valid_search)   { "words" }

  describe "POST #search" do
    context "searching for a Twitter user" do
      it "redirects you to home page when you don't enter a search term" do
        post :search, search_twitter: invalid_search
        expect(response).to redirect_to(root_path)
      end

      it "redirects you to the search show page when you enter a search term" do
        post :search, search_twitter: valid_search
        expect(response).to redirect_to(search_results_path("twitter", valid_search))
      end
    end

    pending "searching for an Instagram user"
  end

  describe "GET #index" do
    context "searching for a Twitter user" do

    end
  end
end
