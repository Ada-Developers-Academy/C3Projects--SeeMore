require 'rails_helper'

RSpec.describe Post, type: :model do

  describe "assocations" do
    let(:post) { create :post }

    it "responds to 'followee' method call" do
      expect(post).to respond_to(:followee)
    end
  end
end
