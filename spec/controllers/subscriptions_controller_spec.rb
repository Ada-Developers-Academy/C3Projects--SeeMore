require 'rails_helper'

RSpec.describe SubscriptionsController, type: :controller do
  before :each do
    @user = User.create(name: "sam", email: "hi@bye.com", uid: 1234, provider: "instagram")
    @followee = Followee.create(handle: "samiam", source: "instagram", native_id: 1)
    @subscription = Subscription.create(user_id: 1, followee_id: 1)
  end

  # these tests aren't working yet
  # describe "GET #index" do
    # it "responds successfully with an HTTP 200 status" do
      # binding.pry
      # get :index
      # expect(response).to be_success
      # expect(response).to have_http_status(200)
    # end

    # it "loads all the subscriptions" do
      # get :index
      # expect(assigns(:subscriptions)).to match_array(@subscription)
    # end
  # end

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
