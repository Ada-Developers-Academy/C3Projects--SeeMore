require 'rails_helper'

RSpec.describe SubscriptionsController, type: :controller do

  describe "GET #index" do
    it "responds successfully with an HTTP 200 status" do
      get :index
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it "loads all the subscriptions" do
      sub1, sub2 = Subscription.create(user_id: 1, followee_id: 1), Subscription.create(user_id: 2, followee_id: 1)
      get :index
      expect(assigns(:subscriptions)).to match_array([sub1, sub2])
    end
  end

  # these tests aren't working yet
  # describe "POST #create" do
  #     let(user) { create :user }
  #     let(followee) { create :followee }
  #
  #   it "creates a new subscription" do
  #     # post :create, :user_id user :followee_id followee
  #     expect(Subscription.count).to eq(1)
  #   end
  # end
  #
  # # describe "POST #unsubscribe" do
  # #   let!(:subscription) { create :subscription }
  # #
  # #   it "adds unsubscribe_date" do
  # #       post :unsubscribe, :id => subscription.user_id
  # #       subscription.reload
  # #       expect(subscription.unsubscribe_date).to eq(!nil)
  # #     end
  # # end

end
