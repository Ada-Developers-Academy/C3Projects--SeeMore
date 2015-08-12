class TwitterHelper
  def self.format_tweet(tweet)
    { uid: tweet.id,
      body:  tweet.text,
      post_time: tweet.created_at,
      url: tweet.url,
      provider: "twitter",
      media: format_media(tweet.media)
    }
  end

  def self.format_media(media)
    media.map do |medium|
      medium.media_url_https.to_s
    end
  end

  def self.format_many_tweets(tweets)
    tweet_array = tweets.map do |tweet|
      format_tweet(tweet)
    end

    # returns nil if there are no tweets
    tweet_array.empty? ? nil : tweet_array
  end

  def self.format_many_prey(prey)
    prey.map do |p|
      format_prey(p)
    end
  end

  def self.format_prey(prey)
    {
      uid: prey.id,
      name: prey.name,
      username: prey.screen_name,
      provider: "twitter",
      photo_url: prey.profile_image_url_https.to_s.sub!('_normal', ''),
      profile_url: prey.url.to_s
    }
  end
end

class InstagramHelper
  def self.format_gram(gram)
    { uid: gram["id"],
      body: (gram["caption"]["text"] unless gram["caption"].nil?),
      post_time: Time.at(gram["created_time"].to_i).to_datetime,
      url: gram["link"],
      provider: "instagram",
      media: [gram["images"]["standard_resolution"]["url"]]
    }
  end

  def self.format_many_grams(grams)
    gram_array = grams.map do |gram|
      format_gram(gram)
    end

    # returns nil if there are no grams
    gram_array.empty? ? nil : gram_array
  end

  def self.format_many_prey(prey)
    prey.map do |p|
      format_prey(p)
    end
  end

  def self.format_prey(prey)
    {
      uid: prey["id"],
      name: prey["full_name"],
      username: prey["username"],
      provider: "instagram",
      photo_url: prey["profile_picture"],
      profile_url: "http://instagram.com/#{prey['username']}" # OPTIMIZE: this line seems fragile!
    }
  end
end
