class SubscriptionsController < ApplicationController
  # before_action :find_user
  before_action :current_user

  def new; end
    # do we need this?

  def create
    followee = Followee.find_or_create_by(followee_params)
    Subscription.make_subscription(@current_user, followee)
    
    redirect_to root_path
  end

  def index
    @subscriptions = @user.followees
  end

  def unsubscribe
    # adds current time to unsubscribe_date
    @subscription = Subscription.find(params[:id])
    @subscription.update(unsubscribe_date: Time.now)
  end

  private

  def find_user
    @user = User.find(session[:user_id])
  end

  def sub_params
    params.require(:subscriptions).permit(:id, :user_id, :followee_id)
  end

  def followee_params
    { source: params[:source],
      username: params[:username],
      id: params[:id],
      picture: params[:profile_picture]
    }
  end
end
