require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  describe "posts#show" do
    let (:params) do
      {
        id: "beastmaster"
      }
    end

    it "returns http success" do
      get :show, :id => params[:id]
      expect(response).to have_http_status(:success)
    end

    it "saves all posts that match the given username" do
      @posts = Post.where(username: "beastmaster")
      create :post

      get :show, :id => params[:id]

      expect(assigns(:posts)).to eq(@posts)
    end
  end
end
