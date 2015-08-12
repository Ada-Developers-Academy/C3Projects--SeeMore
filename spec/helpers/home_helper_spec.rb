require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
  let(:log_in) {
    @logged_user = create :user
    session[:user_id] = @logged_user.id
  }

  describe "checks to see if user has a session" do
    it "returns nil if no session" do

      expect(helper.logged_in?).to eq nil
    end

    it "returns user id if session exists" do
      log_in

      expect(helper.logged_in?).to eq @logged_user.id
    end
  end
end
