require 'rails_helper'

RSpec.describe InstagramController, type: :controller do
  describe "authenticated users" do
    before :each do
      @user = create :au_user
      session[:user_id] = @user.id
    end

    context "results" do
      before :each do
        @search_term = "potatoes"
        get :results, query: @search_term
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
      context "feed that has posts" do
        before :each do
          feed = create :feed
          # FIXME: add VCR here to mimic posts
          get :individual_feed, feed_id: feed.id
        end

        it "responds successfully" do
          expect(response).to be_success
        end

        it "renders the individual_feed template" do
          expect(response).to render_template("individual_feed")
        end

        it "assigns @posts" # FIXME: add VCR here to mimic posts

        it "displays { FILL_ME_IN } results" # FIXME: how many results do we want to display?
      end

      context "feed that doesn't have posts" do
        it "sends an error message" do
          feed = create :feed
          get :individual_feed, feed_id: feed.id

          expect(flash[:error]).not_to be_nil
        end
      end
    end

    context "subscribe" do
      it "associates the feed with the user" do
        feed = create :feed
        post :subscribe, feed_id: feed.id
        expect(@user.feeds).to include(feed)
      end

      it "creates a new database entry if the feed is not found" # FIXME: add VCR here to mimic posts

      it "redirects to the user's feed" do
        feed = create :feed
        post :subscribe, feed_id: feed.id
        expect(response).to redirect_to root_path
      end
    end
  end

  describe "unauthenticated / guest users" do
    context "results" do
      it "redirects to the root_path / login page" do
        search_term = "potatoes"
        get :results, query: search_term
        expect(response).to redirect_to root_path
      end
    end

    context "individual_feed" do
      it "redirects to the root_path / login page" do
        feed = create :feed
        get :individual_feed, feed_id: feed.id
        expect(response).to redirect_to root_path
      end
    end

    context "subscribe" do
      it "redirects to the root_path / login page" do
        feed = create :feed
        post :subscribe, feed_id: feed.id
        expect(response).to redirect_to root_path
      end
    end
  end
end
