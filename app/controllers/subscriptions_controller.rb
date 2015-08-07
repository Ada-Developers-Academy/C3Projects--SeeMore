class SubscriptionsController < ApplicationController
  before_action :find_user

  def new
    # do we need this?
  end

  def create
    # dependent on followee model, and a valid user login
    @followee = Folowee.find(params[:followee_id])
    @subscription = Subscription.create(user_id: session[:user_id], followee_id: @followee.id)
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
