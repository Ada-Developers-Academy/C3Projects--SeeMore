require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) {
    User.new(
      email: "a@b.com",
      name: "Ada",
      uid: "12354",
      provider: "instagram"
      )
    }

    describe "validations" do
      it "is valid" do
        expect(user).to be_valid
      end

      it "requires a name" do
        user.name = nil

        expect(user).to be_invalid
      end

      it "requires a uid" do
        user.uid = nil

        expect(user).to be_invalid
      end

      it "requires a provider" do
        user.provider = nil

        expect(user).to be_invalid
      end
    end
end
