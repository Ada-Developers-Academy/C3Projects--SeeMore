require 'rails_helper'
require 'support/vcr_setup'
require 'twit_init'

RSpec.describe Gram, type: :model do

  describe "validations" do
    context "ig_id" do
      it "doesn't allow duplicates" do
        create :gram, ig_id: "123"
        copycat = build :gram, ig_id: "123"
        copycat.valid?
        expect(copycat.errors.keys).to include(:ig_id)
      end
    end
  end

  describe "methods" do
    context "when a user has just followed an instagram user" do
      it "saves their last five posts" do
        user = create :user
        ig_user = create :instagram_user
        user.instagram_users << ig_user

        VCR.use_cassette 'controller/instagram_new_follow_timeline_api_response' do
          Gram.collect_latest_posts(user)
          expect(Gram.all.count).to eq 5
        end
      end
    end

    context "when a user has already been following an instagram user" do
      it "saves their latest post" do
        user = create :user
        ig_user = create :instagram_user
        user.instagram_users << ig_user
        gram = create :gram, instagram_user_id: 1
        VCR.use_cassette 'controller/instagram_old_followee_api_response' do
          Gram.collect_latest_posts(user)
          expect(Gram.all.count).to eq 1
        end
      end
    end
  end


  # describe "self.collect_latest_posts" do
  #   before :each do
  #     @user = create :user
  #     params = {
  #       username: 'instagram',
  #       profile_pic: 'fake.jpg',
  #       ig_user_id: '25025320',
  #       fullname: 'Instagram'
  #     }
  #     ig_account = InstagramUser.first_or_create_account(params)
  #     @user.instagram_users << ig_account
  #   end

    # it "collects posts from Instagram" do
    #   VCR.use_cassette 'model/gram_collect_posts' do
    #     number_of_inital_posts = @user.grams.count
    #     Gram.collect_latest_posts(@user)
    #
    #     expect(number_of_inital_posts).to eq 0
    #     expect(@user.grams.count).to be > number_of_inital_posts
    #   end
    # end

    # it "collects posts newer than the given min_id" do
    #
    # end
    #
    # it "doesn't collect posts older than the given min_id" do
    #
    # end
    #
    # it "returns posts in descending chronological order" do
    #
    # end
    #
    # context "an account doesn't have saved IG posts " do
    #
    #   it "collects the latest 5 posts from Instagram" do
    #
    #   end
    # end
  # end
end
