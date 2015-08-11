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

    subscription = Subscription.find_or_create_ig_subscription(@instagram_id)

    assign_profile_pic(subscription)

    @user.associate_subscription(subscription)

    flash[:notice] = "Subscribed successfully!"

    redirect_to root_path
  end

  def refresh_recent_ig
    access_token = session[:access_token]

    users_subs = @user.subscriptions

    response = users_subs.map do |subscription|
      if subscription.instagram_id.present?
        HTTParty.get(INSTA_URI + "#{subscription.instagram_id}/media/recent/?count=#{COUNT}&access_token=" + access_token)
      end
    end
raise
    newed_posts = response.first["data"].map do |content|
      assign_post(content)
    end

    check_database(newed_posts)

    redirect_to root_path
  end


  def check_database(content_array)
    content_array.each do |content|
      if Post.where(content_id: content.content_id).empty?
        content.save
      end
    end
  end

  private

  def assign_profile_pic(subscription)
    subscription.profile_pic = params[:profile_pic]

    subscription.save
  end

  def assign_post(content)
    post = Post.new(
      image: [content["images"]["low_resolution"]["url"]],
      posted_at: Time.at(content["created_time"].to_i),
      username: content["user"]["username"],
      content_id: content["id"],
      subscription_id: Subscription.find_by(instagram_id: content["user"]["id"]).id
    )
    unless content["caption"].nil?
      post.text = content["caption"]["text"]
    end
    return post
  end
end
