class TwiSubscriptionsController < ApplicationController

  def index
    client =  twitter_api_object
    @results = client.user_search(params[:twitter_search])
  end

  def create
    subscription = TwiSubscription.create(twitter_id: params[:twitter_id])

    user = User.find(session[:user_id])

    user.twi_subscriptions << subscription
    user.save

    redirect_to root_path
  end

  # def twitter_sub_params
  #   params.require(:)
  # end

end
