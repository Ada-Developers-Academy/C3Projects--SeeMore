require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  describe "GET index" do
    it "requires login" do
      session[:stalker_id] = nil
      get :index

      expect(response).to redirect_to(landing_path)
    end

    context "when signed in" do
      let(:stalker) { create(:stalker) }
      let(:prey) { create(:prey) }
      let(:post) { create(:post) }
      before { session[:stalker_id] = stalker.id }

      it "assigns @stalker" do
        get :index

        expect(assigns(:stalker)).to be_a(Stalker)
      end

      it "assigns @posts" do
        stalker.prey << prey
        get :index

        expect(assigns(:posts)).to include post
      end

      it "@posts excludes posts that belong to prey that the stalker is not subscribed to" do
        get :index

        expect(assigns(:posts)).to_not include post
      end

      it "renders the index template" do
        get :index

        expect(response).to render_template("index")
      end
    end
  end
end
