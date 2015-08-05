require 'rails_helper'

RSpec.describe FolloweesController, type: :controller do
  before_action :find, only: [:destroy]

  def new
    @followee = Followee.new
  end

  def create; end

  def destroy; end

  private

  def find
    @followees = [User.find(session[:user_id]).followees]
  end

  def followee_params
    params.require(:followee).permit(:handle, :source, :avatar_url)
  end
end
