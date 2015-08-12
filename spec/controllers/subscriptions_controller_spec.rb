require 'rails_helper'

RSpec.describe SubscriptionsController, type: :controller do
  describe "POST #create" do
    let(:zynthia) { create :user }

    before :each do
      session[:user_id] = zynthia.id
      post :create, source: "twitter", username: "beyonce", id: "123456", picture: ""
    end

    it "creates a new subscription" do
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

  describe "PUT #unsubscribe" do
    let(:user) { create :user }
    let(:subscription) { create :subscription }

    before :each do
      session[:user_id] = user.id
      put :unsubscribe, :id => subscription.id
      subscription.reload
    end

    it "adds unsubscribe_date" do
      expect(subscription.unsubscribe_date).to_not be_nil
    end

    it "redirects to the subscriptions index" do
      expect(response).to redirect_to subscriptions_path
    end
  end

  describe "GET #index" do
    let(:user) { create :user }

    before :each do
      session[:user_id] = user.id
      followee1 = create :followee
      followee2 = create :followee
      create :subscription, followee_id: followee1.id, user_id: user.id
      create :subscription, followee_id: followee2.id, user_id: user.id
      get :index
    end

    it "renders index template" do
      expect(response).to render_template "index"
    end
  end

  describe "find_followees" do
    let(:user) { create :user }

    before :each do
      session[:user_id] = user.id
      followee1 = create :followee
      followee2 = create :followee
      create :subscription, followee_id: followee1.id, user_id: user.id
      create :subscription, followee_id: followee2.id, user_id: user.id
      get :index
    end

    it "returns an array of followees user's actively following" do

    end
  end
end
