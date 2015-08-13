require 'rails_helper'
require 'twitter_api'
require 'support/vcr_setup'

RSpec.describe TwitterApi do
  let(:twitter_api) { TwitterApi.new }

  describe "#user_search" do
    it "returns three users" do
      VCR.use_cassette 'twitter_api/user_search' do
        @results = twitter_api.user_search("rihanna", 3)
        expect(@results.count).to eq 3
      end
    end
  end

  describe "#embed_html_without_js" do
    let(:tweet_id) { "630946246803361792" }

    it "returns a blockquote" do
      VCR.use_cassette 'twitter_api/embed_html_without_js' do
        @result = twitter_api.embed_html_without_js(tweet_id)
        expect(@result[1..10]).to eq "blockquote"
      end
    end
  end
end
