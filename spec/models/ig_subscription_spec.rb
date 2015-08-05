require 'rails_helper'

RSpec.describe IgSubscription, type: :model do

  describe "model validations" do
    let(:ig_subscription) {
      IgSubscription.new(instagram_id: "@beast")
      }

    it "requires an instagram id" do

      expect(ig_subscription).to be_valid
    end

    it "won't create a subscription without an id" do
      invalid_sub = IgSubscription.new

      expect(invalid_sub).to be_invalid
      expect(invalid_sub.errors.keys).to include(:instagram_id)
    end

    it "wont create a duplicate subscription" do
      ig_subscription.save
      dup_sub = IgSubscription.new(instagram_id: "@beast")

      expect(dup_sub).to be_invalid
      expect(dup_sub.errors.keys).to include(:instagram_id)
    end
  end

end
