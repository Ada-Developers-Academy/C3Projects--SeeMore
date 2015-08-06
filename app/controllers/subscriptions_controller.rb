class SubscriptionsController < ApplicationController
  before_action :find_user

  def new
    @followee = Folowee.find(params[:followee_id])
    @subscription = Subscription.new(user_id: session[:user_id], followee_id: )
  end

  def create
  end


  def show
    # find your followees
    # grab the new tweets/instas
    @following = []
  end

  def unsubscribe
    # adds current time to unsubscribe_date
  end

  private

    def find_user
      @user = User.find(session[:user_id])
    end

    def find_followee
      @followees = @user.followee
    end
end
