require 'rails_helper'

RSpec.describe Followee, type: :model do
  describe "model validations" do
    context "valid" do
      let (:followee) { create :followee }

      it "requires a handle and source" do
        expect(followee).to be_valid
      end
    end

    context "invalid" do
      let (:invalid_followee) {build :followee, handle: nil, source: nil}

      it "requires a handle and source" do
        expect(invalid_followee).to be_invalid
        expect(invalid_followee.errors.keys).to include(:handle, :source)
      end
    end
  end

  # describe "assocations" do
    # before :each do
      # @followee = Followee.create(handle: "samiam", source: "twitter")
    # end

    # it "responds to 'posts' method call" do
      # expect(@followee).to respond_to(:posts)
    # end
  # end
end
