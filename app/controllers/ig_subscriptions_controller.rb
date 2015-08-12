require 'httparty'
class IgSubscriptionsController < ApplicationController

  before_action :redirect_if_not_allowed

  INSTA_URI = "https://api.instagram.com/v1/users/"

  COUNT = 15

  def index
    unless params[:instagram_search].nil?
      @query = params[:instagram_search]

      access_token = session[:access_token]

      response = HTTParty.get(INSTA_URI + "search?q=#{@query}&access_token=" + access_token)

      @response = response["data"]
    end
  end

  def create
    @instagram_id = params[:instagram_id]

    access_token = session[:access_token]

    relationship_check = HTTParty.get(INSTA_URI + "#{params[:instagram_id]}/relationship?access_token=" + access_token)
    if relationship_check["data"]["target_user_is_private"] == true && relationship_check["data"]["outgoing_status"] == "none"

      flash[:error] = "This user is private and thus spared."

      redirect_to root_path
    else

      subscription = Subscription.find_or_create_ig_subscription(@instagram_id)

      assign_profile_pic(subscription)

      @user.associate_subscription(subscription)

      response = []
      response << single_subscription_httparty_object(subscription)
      Post.create_all_instagram_posts(response)

      flash[:notice] = "Subscribed successfully!"

      redirect_to root_path
    end
  end

  def refresh_ig
    user_subs = @user.instagram_subscriptions

    response = multiple_subscription_httparty_objects(user_subs)
    Post.create_all_instagram_posts(response)

    redirect_to refresh_twi_path
  end

  private

  def assign_profile_pic(subscription)
    subscription.profile_pic = params[:profile_pic]

    subscription.save
  end

  # Returns a single HTTParty object for a single subscription.
  def single_subscription_httparty_object(subscription)
    access_token = session[:access_token]

    if subscription.instagram_id.present?
      return HTTParty.get(INSTA_URI + "#{subscription.instagram_id}/media/recent/?count=#{COUNT}&access_token=" + access_token)
    end
  end

  # Returns an array with multiple subscription HTTParty objects (only for Instagram).
  def multiple_subscription_httparty_objects(array_of_subscriptions)
    responses = []
    array_of_subscriptions.each do |subscription|
      responses << single_subscription_httparty_object(subscription)
    end
    return responses # this is an array of HTTParty objects
  end
end
