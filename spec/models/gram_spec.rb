require 'rails_helper'

RSpec.describe Gram, type: :model do
  describe "self.collect_latest_posts" do
    before :each do
      @user = create :user
      params = {
        username: 'instagram',
        profile_pic: 'fake.jpg',
        ig_user_id: '25025320',
        fullname: 'Instagram'
      }
      ig_account = InstagramUser.first_or_create_account(params)
      @user.instagram_users << ig_account
    end

    it "collects posts from Instagram" do
      VCR.use_cassette 'model/gram_collect_posts' do
        number_of_inital_posts = @user.grams.count
        Gram.collect_latest_posts(@user)

        expect(number_of_inital_posts).to eq 0
        expect(@user.grams.count).to be > number_of_inital_posts
      end
    end

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
  end
end
