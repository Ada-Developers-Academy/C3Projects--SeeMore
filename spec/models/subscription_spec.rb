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

  describe ".create" do
    let!(:zynthia) { create :user, id: 1 }
    let!(:beyonce) { create :followee, id: 200, handle: "beyonce", source: "instagram" }

    it "creates a valid subscription to existing followee & user" do
      natgeo = Subscription.make_subscription(zynthia, beyonce)
      expect(natgeo).to be_valid
    end
  end
end # Rspec
