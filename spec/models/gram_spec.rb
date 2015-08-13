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
end
