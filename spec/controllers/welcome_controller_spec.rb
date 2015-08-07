require 'rails_helper'

RSpec.describe WelcomeController, type: :controller do
  describe "authenticated users" do
    context "GET #index" do
      before :each do
        @user = create :au_user
        session[:user_id] = @user.id
      end

      it "responds successfully" do
        get :index
        expect(response).to have_http_status(200)
      end

      it "renders the feed template" do
        get :index
        expect(response).to render_template("feed")
      end

      it "assigns @posts" do
        feed = create :feed
        post = create :post, feed_id: feed.id
        @user.feeds << feed

        get :index
        expect(assigns(:posts)).to include(post)
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
  end
end
