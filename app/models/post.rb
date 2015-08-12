class Post < ActiveRecord::Base
  # Associations
  belongs_to :subscription
  has_many :users, through: :subscription
  serialize :image, Array

  # Validations
  validates_presence_of :username, :posted_at, :content_id, :subscription_id

  # Model Methods

  # Checks with the database to make sure all the posts don't already exist.
  # The HTTParty objects is seperate subscribers for a user.
  def self.create_all_instagram_posts(array_of_httparty_objects)
    newed_post_array = new_all_instagram_posts(array_of_httparty_objects)
    newed_post_array.each do |newed_post|
      create_instagram_post(newed_post)
    end
  end

  # Checks with the database to make sure the post doesn't already exist.
  def self.create_instagram_post(newed_post)
    if where(content_id: newed_post.content_id).empty?
      newed_post.save
    end
  end

  def self.create_twitter_posts(subscription_twitter_ids)
    # passes in a hash where the key is the subscription id
    # and the value is an array of individual tweets
    subscription_twitter_ids.each do |id, tweets|
      # iterates through each tweet and creates it
      # unless it is already in the database
      tweets.each do |tweet|
        unless self.find_by(content_id: tweet.id)
          # needs to be an array because tweets can have more
          # than one photos
          media_array = []
          tweet.media.as_json.each do |media|
            media_array << media["media_url_https"]
          end
          create(
            username: tweet.user.screen_name,
            text: tweet.text,
            posted_at: tweet.as_json["created_at"],
            content_id: tweet.id,
            image: media_array,
            subscription_id: id
            )
        end
      end
    end
  end

  private

    def self.newed_instagram_post(json_content)
      post = Post.new(
        image: [json_content["images"]["low_resolution"]["url"]],
        posted_at: Time.at(json_content["created_time"].to_i),
        username: json_content["user"]["username"],
        content_id: json_content["id"],
        subscription_id: Subscription.find_by(instagram_id: json_content["user"]["id"]).id
      )
      unless json_content["caption"].nil?
        post.text = json_content["caption"]["text"]
      end
      return post
    end

    # Array of HTTParty objects is an array of subscriptions.
    def self.new_all_instagram_posts(array_of_httparty_objects)
      newed_posts = []
      array_of_httparty_objects.each do |all_posts_for_subscriber|
        all_posts_for_subscriber["data"].each do |single_post_json|
          newed_posts << newed_instagram_post(single_post_json)
        end
      end
      return newed_posts
    end
end
