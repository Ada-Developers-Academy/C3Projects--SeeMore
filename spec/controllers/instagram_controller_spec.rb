require 'rails_helper'

RSpec.describe InstagramController, type: :controller do
  describe "authenticated users" do
    before :each do
      @user = create :au_user
      session[:user_id] = @user.id
    end

    context "results" do
      before :each do
        VCR.use_cassette("user_instagram") do
          feed = create :user_instagram
          @search_term = "potato"
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
      context "feed that has posts" do
        let(:feed) {create :user_instagram}
        before :each do
          VCR.use_cassette("user_potato_instagram") do
            @search_term = "potato"
            get :individual_feed, feed_id: feed.platform_feed_id
          end
        end

        it "responds successfully" do
          expect(response).to be_success
        end

        it "renders the individual_feed template" do
          expect(response).to render_template("individual_feed")
        end

        it "assigns @posts" do
          expect(assigns(:posts).first).not_to be_nil
        end
      end
    end

    context "subscribe" do
      before :each do
        request.env["HTTP_REFERER"] = instagram_results_path("cats")
        allow_any_instance_of(Feed).to receive(:populate_posts)
        @feed = create :feed
      end

      it "associates the feed with the user" do
        post :subscribe, feed_id: @feed.id
        expect(@user.feeds).to include(@feed)
      end

      it "redirects to the user's feed" do
        post :subscribe, feed_id: @feed.id
        expect(response).to redirect_to instagram_results_path("cats")
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
        allow_any_instance_of(Feed).to receive(:populate_posts)
        feed = create :feed
        get :individual_feed, feed_id: feed.id
        expect(response).to redirect_to root_path
      end
    end

    context "subscribe" do
      it "redirects to the root_path / login page" do
        allow_any_instance_of(Feed).to receive(:populate_posts)
        feed = create :feed
        post :subscribe, feed_id: feed.id
        expect(response).to redirect_to root_path
      end
    end
  end
end
