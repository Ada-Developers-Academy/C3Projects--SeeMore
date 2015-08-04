require 'rails_helper'

RSpec.describe User, type: :model do




  describe ".initialize_from_omniauth" do
    let(:user) { User.find_or_create_user(OmniAuth.config.mock_auth[:developer]) }

    it "creates a valid user" do
      expect(user).to be_valid
    end

    context "when it's invalid" do
      it "returns nil" do
        user = User.find_or_create_user({"uid" => "123", "info" => {}})
        expect(user).to be_nil
      end
    end
  end
end
