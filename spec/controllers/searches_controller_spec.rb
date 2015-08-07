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

  describe "GET #show" do
    context "searching for a Twitter user" do
      it "responds successfully with an HTTP 200 status code" do
        get :show, client: "twitter", search_term: "search"

        expect(response).to be_success
        expect(response).to have_http_status(200)
      end

      it "renders the show template" do
        get :show, client: "twitter", search_term: "search"

        expect(response).to render_template("show")
      end

      # it 'returns an array of Twitter users' do
      #   uri = URI('https://api.twitter.com')
      #
      #   response = Net::HTTP.get(uri)
      #   expect(response).to be_an_instance_of(Array)
      # end
    end
  end
end
