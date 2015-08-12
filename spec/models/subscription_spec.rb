require 'rails_helper'

RSpec.describe Subscription, type: :model do
  describe "validations" do
    let(:space)  { create :subscription }

    context "user_id and followee_id are required" do
      it "subscription is valid" do
        expect(space).to be_valid
      end

      it "subscription invalid if missing user_id" do
        space.user_id = nil
        expect(space).to be_invalid
      end

      it "subscription invalid if missing followee_id" do
        space.followee_id = nil
        expect(space).to be_invalid
      end
    end # context
  end #describe

  describe ".find_or_create_subscription" do
    let!(:zynthia) { create :user, id: 1 }
    let!(:beyonce) { create :followee, id: 200, handle: "beyonce", source: "instagram" }

    it "creates valid subscription to existing followee & user" do
      natgeo = Subscription.find_or_create_subscription(zynthia, beyonce)
      expect(natgeo).to be_valid
    end

    it "does not remake existing subscription" do
      natgeo = Subscription.find_or_create_subscription(zynthia, beyonce)
      natgeo = Subscription.find_or_create_subscription(zynthia, beyonce)

      expect(Subscription.count).to eq(1)
      expect(Subscription.first).to eq(Subscription.last)
    end

    it "makes a subscription from previously unsubscribed followee" do
      natgeo = Subscription.find_or_create_subscription(zynthia, beyonce)
      # hard-wire unsubscribe date
      natgeo.unsubscribe_date = (Time.now - 10000)
      # re-subscribe
      natgeo = Subscription.find_or_create_subscription(zynthia, beyonce)

      expect(Subscription.count).to eq(1)
      expect(Subscription.first).to eq(Subscription.last)
      expect(natgeo.unsubscribe_date).to eq(nil)
    end
  end

  describe "scopes" do

    context ":active scope" do
      let(:sub)   { create :subscription }
      let(:sub2)  { create :subscription, unsubscribe_date: "Sat, 02 Aug 2015 22:12:25 UTC +00:00" }
      let(:sub3)  { create :subscription, unsubscribe_date: "Sat, 01 Aug 2015 22:12:25 UTC +00:00" }

      it "selects subscriptions that do not have an unsubscribe_date" do
        sub.reload
        sub2.reload
        sub3.reload

        expect(Subscription.count).to eq 3
        expect(Subscription.active.count).to eq 1
      end
    end
  end
end # Rspec
