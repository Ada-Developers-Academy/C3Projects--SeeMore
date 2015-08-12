require 'rails_helper'

RSpec.describe FeedsController, type: :controller do

  before :each do
    @user = create :user
    session[:user_id] = @user.id
    @instagramer = create :instagram, user_ids: [@user.id]
    @tweeter = create :tweet, user_ids: [@user.id]
    @instagram = create :instagram_post, instagram_id: @instagramer.id
    @tweet = create :tweet_post, tweet_id: @tweeter.id
  end

  describe "GET #people" do
    it "renders people template" do
      get :people

      expect(response).to be_success
      expect(response).to render_template("feeds/people")
    end
  end

  describe "GET #index" do
    it "renders the home page" do
      # @all_posts = [{ig_id: @instagram.id, post_id: @instagram.post_id, image_url: @instagram.image_url}]
      get :index

      expect(response).to be_success
      expect(response).to have_http_status(200)
      expect(response).to render_template("feeds/index")
    end
  end

end
