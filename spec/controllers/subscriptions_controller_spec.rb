require 'rails_helper'

RSpec.describe SubscriptionsController, type: :controller do
  # these tests aren't working yet
  describe "POST #create" do
      let!(:zynthia) { create :user, id: 12 }
      let!(:beyonce) { create :followee, id: 100, handle: "beyonce", source: "instagram" }
    # before(:each) do
      # @zynthia = create :user, id: 12
      # @beyonce = create :followee
    # end

    # @followee = Folowee.find(params[:followee_id])
    # @subscription.make_subscription(@user, @followee)

    it "creates a new subscription" do
      # binding.pry
      post :create => :subscription, user: zynthia, followee: beyonce
      subscription.reload
      expect(Subscription.count).to eq(1)
    end
      # it "redirect_to user_path" do
      #   post :create, user: create(:user), followee: create(:followee)
      #   expect(response).to redirect_to(user_path(session[:user_id]))
      #   # undefined method `user_id' for nil:NilClass??
      # end
      # post :create, :user zynthia :followee beyonce
      # expect{post :create, subscription: FactoryGirl.attributes_for(:subscription)}.to change(Subscription, :count).by(1)

  end # create

    # it "redirect_to root_path" do
    #   post :create
    #
    #   expect(response).to redirect_to(root_path)
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
