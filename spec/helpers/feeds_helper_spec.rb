require 'rails_helper'
require 'support/vcr_setup'
require 'twit_init'

RSpec.describe FeedsHelper, type: :helper do

  describe "#tweet_oembed(tweet)" do
    before :each do
      @twit_init = TwitInit.new
    end

    let(:tweet) { Tweet.create(
      tw_id_str: "369557310412029952",
      tw_text: "RT @jleicole For #WHD2013, I ran 5.312 @CharityMiles to help @GirlUp educate girls in the developing world. #EveryMileMatters\n#BeyGood",
      created_time: "2015-08-06 15:07:59 -0700",
      tw_retweet_count: 21626,
      tw_favorite_count: 21046,
      tw_user_id_str: "31239408",
      tw_user_id: 1
      )
    }

    it "returns JSON" do
      VCR.use_cassette 'helpers/twitter_oembed' do
        expect(helper.tweet_oembed(tweet)).to be_a_kind_of Twitter::OEmbed
      end
    end

    it "has HTML embed code" do
      VCR.use_cassette 'helpers/twitter_oembed' do
        expect(helper.tweet_oembed(tweet)).to have_attributes(:html => a_string_starting_with("<"))
      end
    end
  end

  describe "#gram_oembed(post)" do
    let(:gram) { Gram.create(
      tags: "[\"beyoncexflashtattoos\"]",
      media_type: "image",
      created_time:  "Wed, 05 Aug 2015 20:49:47 UTC +00:00",
      link: "https://instagram.com/p/6BATgJPw1v/",
      likes: 817857,
      image_url: "https://scontent.cdninstagram.com/hphotos-xaf1/t51.2885-15/s640x640/e15/11364010_879027568858933_299082807_n.jpg",
      caption: "#BeyonceXFlashTattoos 🐝",
      ig_id: "1045117928711589231_247944034",
      ig_username: "beyonce",
      ig_user_pic: "https://igcdn-photos-g-a.akamaihd.net/hphotos-ak-xft1/t51.2885-19/11098624_1632794343609174_1724291661_a.jpg",
      ig_user_id: "247944034",
      ig_user_fullname: "Beyoncé",
      instagram_user_id: 1
      )
    }

    it "returns JSON" do
      VCR.use_cassette 'helpers/instagram_oembed' do
        expect(helper.gram_oembed(gram).class.to_s).to eq "HTTParty::Response"
      end
    end

    it "has HTML embed code" do
      VCR.use_cassette 'helpers/instagram_oembed' do
        expect(helper.gram_oembed(gram)).to include "html"
      end
    end
  end
end
