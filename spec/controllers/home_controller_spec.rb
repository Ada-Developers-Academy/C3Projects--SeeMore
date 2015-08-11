require 'rails_helper'
require 'support/vcr_setup'

RSpec.describe HomeController, type: :controller do
  let(:user) { create :user }
  before :each do
    session[:user_id] = user.id
  end

  describe "GET #newsfeed" do

    before :each do
      get :newsfeed
    end

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    # it "finds the current user" do
    #   binding.pry
    #   expect(@current_user).to eq user
    # end

    # it "doesn't find the current user if none set" do
    #   session[:user_id] = nil
    #   expect(@current_user).to be_nil
    # end
  end

  # describe "get_posts_from_API" do
  #   let(:followee) { create :followee }

  #   it "returns a collection of posts" do
  #     VCR.use_cassette 'controller/home_controller/get_posts_from_API' do
  #       posts = get_posts_from_API(followee)
  #       expect(posts).to_not be_nil
  #     end
  #   end
  # end

  describe "POST #get_new_posts" do
    let(:followee) { create :followee }

    context "updating feed after following new user" do
      it "adds posts to the database" do
        VCR.use_cassette 'controller/home_controller/get_new_posts' do
          create :subscription, followee_id: followee.id, user_id: user.id
          post :get_new_posts
          expect(Post.count).to eq 5
        end
      end
    end
  end
end
