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

  describe "#embed_html_with_js" do
    let(:instagram_link) { "http://instagr.am/p/D/" }

    before :each do
      VCR.use_cassette 'instagram_api/embed_html_with_js' do
        @response = instagram_api.embed_html_with_js(instagram_link)
      end
    end

    it "returns a blockquote" do
      expect(@response[1..10]).to eq "blockquote"
    end

    it "returns a script" do
      expect(@response[-7..-2]).to eq "script"
    end
  end

  describe "#query_API_for_posts" do
    context "last_post_id present" do
      let(:followee) { create :followee, handle: "barrackobama", native_id: "10206720", last_post_id: "914665339329635845_10206720", source: "instagram" } # 3 back 

      # the last post id was >= 3 back for the followee
      it "returns posts when posts have been made since last_post_id" do
        VCR.use_cassette 'instagram_api/query_API_for_posts_with_last_post_id' do
          id = followee.native_id
          last_post_id = followee.last_post_id
          response = instagram_api.query_API_for_posts(id, last_post_id)

          expect(response.count).to eq 3
        end
      end
    end

    context "last_post_id absent" do
      let(:followee) { create :followee, handle: "barrackobama", native_id: "10206720", last_post_id: nil, source: "instagram" }
      
      it "returns 1 post" do
        VCR.use_cassette 'instagram_api/query_API_for_posts_without_last_post_id' do
          id = followee.native_id
          last_post_id = followee.last_post_id
          response = instagram_api.query_API_for_posts(id, last_post_id)

          expect(response.count).to eq 1
        end
      end
    end
  end
end
