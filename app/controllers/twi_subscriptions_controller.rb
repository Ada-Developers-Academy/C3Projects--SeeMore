class TwiSubscriptionsController < ApplicationController

  def index
    client =  twitter_api_object
    @results = client.user_search(params[:twitter_search])
  end

  def create
    # Calling find_or_create_subscription and associate_subscription model methods.
    subscription = TwiSubscription.find_or_create_subscription(params[:twitter_id])

    @user.associate_subscription(subscription)

    flash[:notice] = "Subscribed successfully!"

    redirect_to root_path
  end
end
