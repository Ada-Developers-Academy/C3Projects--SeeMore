require 'rails_helper'

RSpec.describe Tweet, type: :model do

  describe "validations" do

    context "twitter user id" do
      it "requires a twitter user id" do
        tweet = build :tweet, tw_user_id_str: nil
        tweet.valid?
        expect(tweet.errors.keys).to include(:tw_user_id_str)
      end

      it "requires a twitter user id to be unique" do
      end

    end

    it "requires unique tweet ids" do
    end

    it "requires a tweet created_at time" do
    end

    it "requires tweet text" do
    end

    it "requires a foreign key" do
    end

  end
end
