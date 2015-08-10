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
  pending "add some examples to (or delete) #{__FILE__}"

  pending "#update_tweets"
  pending "seeds tweets after create"
end
