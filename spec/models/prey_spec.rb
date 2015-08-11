require 'rails_helper'

RSpec.describe Prey, type: :model do
  describe "model validations" do
    it "creates a valid Prey" do
      prey = build(:prey)

      expect(prey).to be_valid
    end

    it "requires uid" do
      prey = build(:prey, uid: nil)

      expect(prey).to be_invalid
      expect(prey.errors).to include(:uid)
    end

    it "requires provider" do
      prey = build(:prey, provider: nil)

      expect(prey).to be_invalid
      expect(prey.errors).to include(:provider)
    end
  end

  describe "tweeter?" do
    context "when prey's provider is twitter" do
      it "returns true" do
        prey = build(:prey, provider: "twitter")

        expect(prey.tweeter?).to be true
      end
    end

    context "when prey's provider is instagram" do
      it "returns false" do
        prey = build(:prey, provider: "instagram")

        expect(prey.tweeter?).to be false
      end
    end
  end

  describe "grammer?" do
    context "when prey's provider is instagram" do
      it "returns true" do
        prey = build(:prey, provider: "instagram")

        expect(prey.grammer?).to be true
      end
    end

    context "when prey's provider is twitter" do
      it "returns false" do
        prey = build(:prey, provider: "twitter")

        expect(prey.grammer?).to be false
      end
    end
  end

  pending "#update_posts"
  pending "seeds posts after create"
end
