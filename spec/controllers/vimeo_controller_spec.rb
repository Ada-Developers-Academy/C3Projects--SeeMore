require 'rails_helper'
require 'webmock/rspec'

RSpec.describe VimeoController, type: :controller do

  describe '#call_api' do
    let(:query) { "cupcakes" }
    let(:user) { create :au_user}
    it "gets a response from an api" do
      VCR.use_cassette "vimeo_query" do
        session[:user_id] = user.id
        get :results, query: query
        expect(assigns(:results).first["name"]).to eq "Cupcake"
      end
    end
  end

  describe "authenticated users" do
    before :each do
      @user = create :au_user
      session[:user_id] = @user.id
    end

    context "results" do
      before :each do
        @search_term = "potatoes"
        VCR.use_cassette("/vimeo_user") do
          get :results, query: @search_term
        end
      end

      it "responds successfully" do
        expect(response).to be_success
      end

      it "renders the results template" do
        expect(response).to render_template("results")
      end

      it "assigns @query" do
        expect(assigns(:query)).to eq(@search_term)
      end

      it "assigns @results" do
        expect(assigns(:results)).not_to be_nil
      end
    end

    context "individual_feed" do
      let(:feed) { create :user_vimeo}
      context "feed that has posts" do
        before :each do
          VCR.use_cassette("/vimeo_feed") do
            get :individual_feed, feed_id: feed.id
          end
        end

        it "responds successfully" do
          expect(response).to be_success
        end

        it "renders the individual_feed template" do
          expect(response).to render_template("individual_feed")
        end

        it "assigns @posts" do
          expect(assigns(:posts).first["name"]).to eq "Light Therapy"
        end
      end
    end

    context "subscribe" do
      let(:feed) { create :user_vimeo}
      before(:each) do
        request.env["HTTP_REFERER"] = instagram_results_path("cats")
      end
      it "associates the feed with the user" do
        VCR.use_cassette("/subscribe") do
          post :subscribe, feed_id: feed.id
          expect(@user.feeds).to include(feed)
        end
      end

      it "creates a new database entry if the feed is not found" do
        post :subscribe, feed_id: feed.id
        expect(Feed.count).to eq(1)
      end

      it "redirects to the user's feed" do
        VCR.use_cassette("/subscribe") do
          post :subscribe, feed_id: feed.id
          expect(response).to redirect_to(instagram_results_path("cats"))
        end
      end

      it "doesn't add a new subscription if a user has already subcribed" do
        VCR.use_cassette("/subscribe") do
          post :subscribe, feed_id: feed.id
          post :subscribe, feed_id: feed.id
          post :subscribe, feed_id: feed.id
          expect(@user.feeds).to include(feed)

          matching_feeds = @user.feeds.select{ |f| f.id == feed.id }
          expect(matching_feeds.count).to eq(1)
        end
      end
    end

    context "unsubscribe" do
      let(:feed) { create :user_vimeo }

      before(:each) do
        request.env["HTTP_REFERER"] = instagram_results_path("cats")
        @user.feeds << feed
      end

      it "removes association between the feed and the user" do
        VCR.use_cassette("/subscribe") do
          delete :unsubscribe, feed_id: feed.id
          @user.reload
          expect(@user.feeds).not_to include(feed)
        end
      end

      it "destroys the feed if no other users are associated" do
        VCR.use_cassette("/subscribe") do
          delete :unsubscribe, feed_id: feed.id
          @user.reload
          expect{ feed.reload }.to raise_exception(ActiveRecord::RecordNotFound)
        end
      end

      it "redirects the user back from whence it came" do
        VCR.use_cassette("/subscribe") do
          delete :unsubscribe, feed_id: feed.id
          expect(response).to redirect_to(instagram_results_path("cats"))
        end
      end
    end
  end

  describe "unauthenticated / guest users" do
    let(:feed) { create :user_vimeo }
    context "results" do
      it "redirects to the root_path / login page" do
        search_term = "potatoes"
        get :results, query: search_term
        expect(response).to redirect_to root_path
      end
    end

    context "individual_feed" do
      it "redirects to the root_path / login page" do
        get :individual_feed, feed_id: feed.id
        expect(response).to redirect_to root_path
      end
    end

    context "subscribe" do
      it "redirects to the root_path / login page" do
        post :subscribe, feed_id: feed.id
        expect(response).to redirect_to root_path
      end
    end
  end
end
