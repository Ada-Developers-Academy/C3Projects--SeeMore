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

    context "updating feed for a new followee" do
      let(:followee_twitter) { create :followee, last_post_id: nil }
      let(:followee_instagram) { create :followee, handle: "badgalriri", source: "instagram", native_id: "25945306", last_post_id: nil }

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

      it "adds 2 Instagram posts to the database" do
        expect(Post.where(source: "instagram").count).to eq 2
      end
    end
  end
end
