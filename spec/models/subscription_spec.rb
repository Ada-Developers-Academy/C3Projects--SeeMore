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

  describe ":active scope" do
    let(:sub)   { create :subscription }
    let(:sub2)  { create :subscription }
    let(:sub3)  { create :subscription }
  
    it "selects subscriptions that do not have an unsubscribe_date" do
      sub.unsubscribe_date = nil
      sub2.unsubscribe_date = "Sat, 02 Aug 2015 22:12:25 UTC +00:00"
      sub3.unsubscribe_date = "Sat, 01 Aug 2015 22:12:25 UTC +00:00"

      expect(sub.unsubscribe_date).to eq nil
      expect(sub3.unsubscribe_date).to eq "Sat, 01 Aug 2015 22:12:25 UTC +00:00"
      expect(Subscription.count).to eq 3
      expect(Subscription.active.count).to eq 1
    end

  end
end # Rspec
