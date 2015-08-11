require 'rails_helper'

RSpec.describe TwUser, type: :model do
  describe "validaions" do
    it "requires a tw_user_id_str" do
      twitter_user = build :tw_user, tw_user_id_str: nil
      twitter_user.valid?
      expect(twitter_user.errors.keys).to include(:tw_user_id_str)
    end
  end
end
