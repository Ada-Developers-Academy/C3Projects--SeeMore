class TwiSubscriptionsController < ApplicationController
  before_action :redirect_if_not_allowed

  def index
    # Guard in case someone tries to access the URL without any search results.
    unless params[:twitter_search].nil?
      client = twitter_api_object
      @results = client.user_search(params[:twitter_search])
    end
  end

  def create
    # Calling find_or_create_subscription and associate_subscription model methods.
    subscription = TwiSubscription.find_or_create_subscription(params[:twitter_id])

    @user.associate_subscription(subscription)

    flash[:notice] = "Subscribed successfully!"

    redirect_to root_path
  end
end
