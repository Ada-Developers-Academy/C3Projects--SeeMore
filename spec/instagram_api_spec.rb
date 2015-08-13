require 'rails_helper'
require 'instagram_api'
require 'support/vcr_setup'

RSpec.describe InstagramApi do
  let(:instagram_api) { InstagramApi.new }

  # results.count will equal 4 if the search term is "rihanna"
  # not sure why -- is this a known instagram bug?
  describe "#user_search" do
    it "returns up to a specified number of users" do
      VCR.use_cassette 'instagram_api/user_search' do
        results = instagram_api.user_search("beyonce", 3)
        expect(results.count).to be <= 3
      end
    end
  end

  describe "#private_user?" do
    it "returns a truthy value for private user" do
      VCR.use_cassette 'instagram_api/private_user' do
        private_user_id = "184517457"
        result = instagram_api.private_user?(private_user_id)
        expect(result).to be_truthy
      end
    end

    it "returns a falsy value for non-private user" do
      VCR.use_cassette 'instagram_api/non_private_user' do
        non_private_user_id = "9266829"
        result = instagram_api.private_user?(non_private_user_id)
        expect(result).to be_falsy
      end
    end
  end
end
