require 'rails_helper'

RSpec.describe SubscriptionsController, type: :controller do
  describe "GET #index" do

  end

  describe "GET #show" do

  end

  describe "GET #new" do
    # get :new, :user_id @user, :followee_id @followee

    # expect(Subscription.count).to
  end

  describe "POST #create" do
      let(user) { create :user }
      let(followee) { create :followee }

    it "creates a new subscription" do
      post :create, :user_id user :followee_id followee
      expect(Subscription.count).to eq(1)
    end
  end

end
