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
end
