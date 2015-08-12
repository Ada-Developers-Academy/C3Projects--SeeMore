class TwitterHelper
  def self.create_params(tweet)
    { uid: tweet.id,
      body:  tweet.text,
      post_time: tweet.created_at,
      prey_id: Prey.find_by(uid: tweet.user.id).id,
      url: tweet.url,
      provider: "twitter"
    }
  end
end

class InstagramHelper
  def self.create_params(gram)
    { uid: gram["id"],
      body: (gram["caption"]["text"] unless gram["caption"].nil?),
      post_time: convert_unix_to_datetime(gram["created_time"]),
      prey_id: Prey.find_by(uid: gram["user"]["id"]).id,
      url: gram["link"],
      provider: "instagram"
    }
  end
end
