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

end
