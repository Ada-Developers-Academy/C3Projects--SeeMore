require 'rails_helper'

RSpec.describe WelcomeController, type: :controller do
  describe "authenticated users" do
    before :each do
      @user = create :au_user
      session[:user_id] = @user.id
    end

    context "GET #index" do
      it "responds successfully" do
        get :index
        expect(response).to have_http_status(200)
      end

      it "renders the feed template" do
        get :index
        expect(response).to render_template("feed")
      end

      it "assigns @posts" do
        allow_any_instance_of(Feed).to receive(:populate_posts)
        feed = create :feed
        post = create :post, feed_id: feed.id
        @user.feeds << feed

        get :index
        expect(assigns(:posts)).to include(post)
      end
    end

    context "search" do
      context "valid form input" do
        it "redirects to Instagram results path for Instagram searches" do
          search_term = "potatoes"
          post :search, search: { query: search_term, platform: "Instagram" }
          expect(response).to redirect_to(instagram_results_path(search_term))
        end

        it "redirects to Vimeo results path for Vimeo searches" do
          search_term = "potatoes"
          post :search, search: { query: search_term, platform: "Vimeo" }
          expect(response).to redirect_to(vimeo_results_path(search_term))
        end
      end

      context "invalid form input" do
        it "flashes an error message" do
          request.env["HTTP_REFERER"] = root_path
          post :search, search: { platform: "bad input", query: "potatoes" }
          expect(flash[:error]).not_to be_nil
        end

        it "redirects to the previous page" do
          request.env["HTTP_REFERER"] = instagram_results_path("cats")
          post :search, search: { platform: "bad input", query: "potatoes" }
          expect(response).to redirect_to(instagram_results_path("cats"))
        end
      end
    end
  end

  describe "unauthenticated / guest users" do
    context "GET #index" do
      before :each do
        get :index
      end

      it "responds successfully" do
        expect(response).to have_http_status(200)
      end

      it "renders the login template" do
        expect(response).to render_template("login")
      end
    end

    context "search" do
      it "redirects to the root_path / login page" do
        search_term = "potatoes"
        post :search, search: { query: search_term, platform: "Instagram" }
        expect(response).to redirect_to root_path
      end
    end
  end
end
