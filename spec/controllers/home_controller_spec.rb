require 'rails_helper'
require 'support/vcr_setup'

RSpec.describe HomeController, type: :controller do
  let!(:user) { create :user }
  before :each do
    session[:user_id] = user.id
  end

  describe "GET #newsfeed" do

    context "user has no subscription" do

      before :each do
        get :newsfeed
      end

      it "returns http success" do
        expect(response).to have_http_status(200)
      end

      it "should display a flash error" do
        expect(flash[:errors]).to include("You have no subscriptions! Search users to subscribe to.")
      end
    end

    context "user has subscriptions" do
      let!(:souly) { create :user, id: 20 }
      let!(:buzz) { create :followee, id: 15 }
      let!(:subscription) { create :subscription, followee_id: 15, user_id: 20, created_at: (Time.now - 10) }
      let!(:post) { create :post, followee_id: 15, native_created_at: Time.now + 1 }
      let!(:post1) { create :post, followee_id: 15, native_created_at: Time.now + 1 }

      it "should have @rev_posts" do
        session[:user_id] = souly.id
        get :newsfeed
        expect(assigns[:rev_posts].count).to eq(2)
      end
    end

  end # newsfeed

    # it "finds the current user" do
    #   binding.pry
    #   expect(@current_user).to eq user
    # end

    # it "doesn't find the current user if none set" do
    #   session[:user_id] = nil
    #   expect(@current_user).to be_nil
    # end

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
        VCR.use_cassette 'controller/home_controller/get_newsfeed_last_post_id_absent' do
          create :subscription, followee_id: followee_twitter.id, user_id: user.id
          create :subscription, followee_id: followee_instagram.id, user_id: user.id

          get :newsfeed
          expect(Post.count).to eq 2
        end
      end
    end

    context "updating feed for an existing followee" do
      let(:followee_twitter) { create :followee, handle: "rhomieux", native_id: "11583102", last_post_id: "630946246803361792"} # 3 back
      let(:followee_instagram) { create :followee, handle: "barrackobama", native_id: "10206720", last_post_id: "914665339329635845_10206720", source: "instagram" } # 3 back

      before(:each) do
        VCR.use_cassette 'controller/home_controller/get_newsfeed_last_post_id_present' do
          create :subscription, followee_id: followee_twitter.id, user_id: user.id
          create :subscription, followee_id: followee_instagram.id, user_id: user.id

          get :newsfeed
        end
      end

      # it "adds 2 Twitter posts to the database" do
      #   expect(Post.where(source: "twitter").count).to eq 2
      # end

      it "adds 2 Instagram posts to the database" do
        expect(Post.where(source: "instagram").count).to eq 2
      end
    end
  end
end
