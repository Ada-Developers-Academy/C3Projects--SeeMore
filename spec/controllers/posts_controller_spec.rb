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
      before { session[:stalker_id] = stalker.id }

      it "assigns @stalker" do
        get :index

        expect(assigns(:stalker)).to be_a(Stalker)
      end

      pending "assigns @posts"
      # it "assigns @posts" do
      #   get :index

      #   expect(assigns(:posts)).to #??
      # end

      # it "@posts excludes posts that belong to prey that the stalker is not subscribed to" do
      # end

      it "renders the index template" do
        get :index

        expect(response).to render_template("index")
      end
    end
  end
end
