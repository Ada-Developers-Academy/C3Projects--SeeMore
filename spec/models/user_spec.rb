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
        expect(user.errors.keys).to include(:name)
      end

      it "requires a uid" do
        user.uid = nil

        expect(user).to be_invalid
        expect(user.errors.keys).to include(:uid)
      end

      it "requires a provider" do
        user.provider = nil

        expect(user).to be_invalid
        expect(user.errors.keys).to include(:provider)
      end

      it "name has to be unique" do
        user.save

        user2 = User.create(name: "Ada")

        expect(user2).to be_invalid
        expect(user2.errors.keys).to include(:name)
      end

      it "uid has to be unique" do
        user.save

        user2 = User.create(uid: "12354")

        expect(user2).to be_invalid
        expect(user2.errors.keys).to include(:uid)
      end
    end
end
