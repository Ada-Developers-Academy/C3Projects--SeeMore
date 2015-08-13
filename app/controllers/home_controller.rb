class HomeController < ApplicationController

  def index
    if logged_in?
      @posts = @user.posts.sorted_order
    end
  end

  def search
    if params[:search].nil? || params[:search].empty?
      flash[:error] = "Please enter text into the search box."
      redirect_to root_path
    elsif params[:website] == "twitter"
      redirect_to twi_subscriptions_path(params: {twitter_search: params[:search]})
    else
      # when the website is instagram
      redirect_to ig_subscriptions_path(params: {instagram_search: params[:search]})
    end
  end

  # list of a user's subcriptions
  def subscriptions
    posts = @user.posts

    sub_array = []

    posts.each do |post|
      sub_array << [post.subscription_id, post.username]
    end

    @sub_array = sub_array.uniq

    @sub_array.each do |post|
      id = post[0]
      subscription = Subscription.find(id)
      pic = subscription.profile_pic
      post << pic
    end
  end

  def unfollow
    subscription = Subscription.find(params[:subscription_id])
    @user.dissociate_subscription(subscription)
    redirect_to subscriptions_path
  end
end
