module FeedsHelper
  def tweet_oembed(tweet)
    @twit_init.client.oembed(tweet.tw_id_str, { omit_script: true })
  end

  def gram_oembed(post)
    HTTParty.get("http://api.instagram.com/oembed?url=http://instagr.am/#{post.link[22,20]}")
  end
end
