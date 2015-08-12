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

  describe "#tweeter?" do
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

  describe "#grammer?" do
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

  describe "#seed_posts (using Twitter)" do
    let(:prey_params_with_valid_uid) { { name: "Ashley Watkins",
      username: "catchingash",
      provider: "twitter",
      uid: "3037739230",
      photo_url: "https://pbs.twimg.com/profile_images/625870213901193216/usGZawYA_normal.jpg",
      profile_url: "https://twitter.com/catchingash"
    } }

    before :each do
      VCR.use_cassette('seeds_5_tweets') do
        prey = Prey.create(prey_params_with_valid_uid)
        # # ALT: if we did NOT want to seed posts on create:
        # prey = Prey.new( [...] )
        # allow(prey).to receive(:seed_posts).and_return(true)
        # prey.save
      end
    end

    it "seeds 5 posts on create" do
      expect(Post.count).to eq(5)
    end
  end

  pending "#seed_posts (using Instagram)"

  pending ".last_post_uid"

  pending "#update_posts"
  # def update_posts
  #   Post.update_tweets(uid, id) if tweeter?
  #   Post.update_grams(uid, id) if grammer?
  # end

end



