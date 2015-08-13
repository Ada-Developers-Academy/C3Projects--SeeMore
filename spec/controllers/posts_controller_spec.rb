require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  describe "posts#show" do
    let (:params) do
      {
        id: "beastmaster",
        username: "beastmaster"
      }
    end

    it "returns http success" do
      get :show, :id => params[:username]

      expect(response).to have_http_status(:success)
    end

    it "saves all posts that match the given username" do
      @posts = Post.where(username: "beastmaster").sorted_order
      create :post
      get :show, {:id => params[:id], username: params[:username]}

      expect(assigns(:posts)).to eq(@posts)
    end
  end
end
