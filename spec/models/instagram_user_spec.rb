require 'rails_helper'

RSpec.describe InstagramUser, type: :model do
  describe "#first_or_create_account" do
    before :each do
      @ig_user = create :instagram_user
      @account_info = {
        username: 'OOP4lyfe',
        profile_pic: 'oop.jpg',
        ig_user_id: '3948820',
        fullname: 'Sandy Metz'
      }
    end

    context "the IG account exists in the database" do
      it "returns account's corresponding InstagramUser object" do
        account = InstagramUser.first_or_create_account(@ig_user)
        expect(account).to eq @ig_user
      end
    end

    context "the IG account doesn't exist in the database" do
      it "create an InstagramUser object" do
        account = InstagramUser.first_or_create_account(@account_info)
        expect(account).to be_instance_of(InstagramUser)
      end
    end
  end
end
