class SubscriptionsController < ApplicationController
  before_action :find_user

  def new; end
    # do we need this?

  def create
    # if followee not in db, add to db
    followee = Followee.find_or_create_by(params[:id])
        # how to get the whole of user passed into method above?
    # need to also persist the params[:source]
    Subscription.make_subscription(session[:user_id], followee)

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
end
