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

    context "updating feed for a new followee" do
      let(:followee_twitter) { create :followee }
      let(:followee_instagram) { create :followee, handle: "badgalriri", source: "instagram", native_id: "25945306" }
      
      it "adds posts to the database" do
        VCR.use_cassette 'controller/home_controller/get_new_posts_last_post_id_absent' do
          create :subscription, followee_id: followee_twitter.id, user_id: user.id
          create :subscription, followee_id: followee_instagram.id, user_id: user.id

          post :get_new_posts
          expect(Post.count).to eq 10
        end
      end
    end

    context "updating feed for an existing followee" do
      let(:followee_twitter) { create :followee, handle: "rhomieux", native_id: "11583102", last_post_id: "630946246803361792"} # 3 back
      let(:followee_instagram) { create :followee, handle: "barrackobama", native_id: "10206720", last_post_id: "914665339329635845_10206720", source: "instagram" } # 3 back

      it "adds posts to the database" do
        VCR.use_cassette 'controller/home_controller/get_new_posts_last_post_id_present' do
          create :subscription, followee_id: followee_twitter.id, user_id: user.id
          create :subscription, followee_id: followee_instagram.id, user_id: user.id

          post :get_new_posts
          expect(Post.where(source: "twitter").count).to eq 2
          # expect(Post.where(source: "instagram").count).to eq 2
        end
      end
    end
  end
end
