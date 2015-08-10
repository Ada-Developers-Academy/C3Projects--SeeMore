class Post < ActiveRecord::Base
  # Associations
  belongs_to :subscription
  has_many :users, through: :subscription
  serialize :image, Array

  #Validations
  validates_presence_of :username, :posted_at, :content_id, :subscription_id

  #Scope
  # scope :

  def self.create_twitter_posts(tweet_array, subscription)
    tweet_array.each do |tweet|
      unless self.find_by(content_id: tweet.id)
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
          subscription_id: subscription.id
        )
      end
    end
  end

  private
      # def self.in_database(id)
      #   where(content_id: id)
      # end

  # check to see if you have access to the user, if don't have access, don't
  # show them stuff they don't have access to

  # moved from the home controller, not sure where it will need to be in the end
  #   if logged_in?
  #     twitter_ids = @user.subscriptions.pluck(:twitter_id)

  #     @sub_array_tweets = []

  #     twitter_ids.each do |twitter_id|
  #         @sub_array_tweets << tweet
  #       end
  #     end

  #     @sub_array_tweets.sort! { |a,b| b.as_json["created_at"].to_time <=> a.as_json["created_at"].to_time }

      # could transform tweets into our own "post" object...
      # need to combine
  #   end
#   end

end
