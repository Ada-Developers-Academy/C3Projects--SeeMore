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
    let(:twitter_params_with_valid_uid) { { name: "Ashley Watkins",
      username: "catchingash",
      provider: "twitter",
      uid: "3037739230",
      photo_url: "https://pbs.twimg.com/profile_images/625870213901193216/usGZawYA_normal.jpg",
      profile_url: "https://twitter.com/catchingash"
    } }

    before :each do
      VCR.use_cassette('seeds_5_tweets') do
        Prey.create(twitter_params_with_valid_uid)
      end
    end

    it "seeds 5 posts on create" do
      expect(Post.count).to eq(5)
    end
  end

  describe "#seed_posts (using Instagram)" do
    let(:instagram_params_with_valid_uid) { { name: "ada test",
      username: "testada",
      provider: "instagram",
      uid: "1905138160",
      photo_url: "https://igcdn-photos-g-a.akamaihd.net/hphotos-ak-xfa1/t51.2885-19/s150x150/11821730_1466159010375262_1430176978_a.jpg",
      profile_url: "http://instagram.com/testada"
    } }

    before :each do
      VCR.use_cassette('seeds_5_grams') do
        Prey.create(instagram_params_with_valid_uid)
      end
    end

    it "seeds 5 posts on create" do
      expect(Post.count).to eq(5)
    end
  end

  describe ".last_post_uid" do
    let(:prey) do
      prey = build(:prey)
      allow(prey).to receive(:seed_posts).and_return(true)
      prey.save && prey
    end

    let(:other_post) { create(:post, prey_id: prey.id, uid: "12345" ) }
    let(:post) { create(:post, prey_id: prey.id, uid: "54321" ) }

    it "returns largest uid" do
      other_post && post # these posts need to exist in the db before the method call
      expect(Prey.last_post_uid(prey.uid)).to eq(post.uid)
    end

    context "the prey has no posts" do
      it "returns nil" do
        expect(Prey.last_post_uid(prey.uid)).to eq(nil)
      end
    end
  end

  pending "#update_posts"
  # def update_posts
  #   Post.update_tweets(uid, id) if tweeter?
  #   Post.update_grams(uid, id) if grammer?
  # end

end



