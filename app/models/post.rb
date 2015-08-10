class Post < ActiveRecord::Base
  # Associations
  belongs_to :subscription
  has_many :users, through: :subscription

  #Validations
  validates_presence_of :username, :posted_at, :content_id, :subscription_id

  # moved from the home controller, not sure where it will need to be in the end
  #   if logged_in?
  #     client = twitter_api_object
  #     twitter_ids = @user.subscriptions.pluck(:twitter_id)

  #     @sub_array_tweets = []

  #     twitter_ids.each do |twitter_id|
  #       client.user_timeline(twitter_id.to_i).each do |tweet|
  #         @sub_array_tweets << tweet
  #       end
  #     end

  #     @sub_array_tweets.sort! { |a,b| b.as_json["created_at"].to_time <=> a.as_json["created_at"].to_time }

      # could transform tweets into our own "post" object...
      # need to combine
  #   end
#   end
#   tweet.user.screen_name
#  tweet.text
#   tweet.as_json["created_at"]
# tweet.media.as_json.each do |media|
#    image_tag(media["media_url_https"], height: '300' )



end
