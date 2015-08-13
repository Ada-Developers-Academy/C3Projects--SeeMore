require 'rails_helper'
require 'twitter_api'
require 'support/vcr_setup'

RSpec.describe TwitterApi do
  let(:twitter_api) { TwitterApi.new }

  describe "#user_search" do
    it "returns up to a specified number of users" do
      VCR.use_cassette 'twitter_api/user_search' do
        results = twitter_api.user_search("rihanna", 3)
        expect(results.count).to be <= 3
      end
    end
  end

  describe "#embed_html_without_js" do
    let(:tweet_id) { "630946246803361792" }

    it "returns a blockquote" do
      VCR.use_cassette 'twitter_api/embed_html_without_js' do
        result = twitter_api.embed_html_without_js(tweet_id)
        expect(result[1..10]).to eq "blockquote"
      end
    end
  end

  # def get_posts(id, last_post_id)
  #   client.user_timeline(id, timeline_options(last_post_id))
  # end

  ###### this spec is currently broken
  # describe "#get_posts" do
  #   context "last_post_id present" do
  #   let(:followee) { create :followee }

  #     it "gets a collection of posts for a followee" do
  #       VCR.use_cassette 'twitter_api/get_posts_last_post_id_present' do
  #         # binding.pry
  #         id = followee.id
  #         last_post_id = followee.last_post_id
  #         @posts = twitter_api.get_posts(id, last_post_id)
  #         expect(@posts.count).to_be > 0
  #       end
  #     end
  #   end

  #   context "last_post_id absent" do
  #     it "gets 1 post for a followee" do
  #     end
  #   end
  # end
end
