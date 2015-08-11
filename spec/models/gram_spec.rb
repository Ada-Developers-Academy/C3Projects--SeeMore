require 'rails_helper'

RSpec.describe Gram, type: :model do
  # describe "scope #latest_posts(limit)" do
  #   before :each do
  #     3.times do
  #       create :gram
  #     end

  #     @post4 = create :gram
  #     @post5 = create :gram
  #   end

  #   it "retrieves the latest posts" do
  #     posts = Gram.latest_posts(2)

  #     expect(posts).to include @post4
  #     expect(posts).to include @post5
  #   end

  #   it "returns number of posts according to limit parameter" do
  #     three_posts = Gram.latest_posts(3)
  #     one_post = Gram.latest_posts(1)

  #     expect(three_posts.count).to eq 3
  #     expect(one_post.count).to eq 1
  #   end

  #   it "returns posts in reverse chronological order" do
  #     posts = Gram.latest_posts(3)

  #     expect(posts[0].created_at).to be > posts[1].created_at
  #     expect(posts[1].created_at).to be > posts[2].created_at
  #     expect(posts[2].created_at).to be < posts[0].created_at
  #   end
  # end

  # describe "scope #whatsnew(min_id)" do
  #   before :each do 
  #     35.times do |i|
  #       create :gram, ig_id: i
  #     end
  #   end


  #   it "returns an array of Instagram posts" do
  #     result = Gram.whatsnew(20)
  #     expect(result).to be_a Array
  #   end

  #   it "does not return posts older than the given id" do
  #     result= Gram.whatsnew(5)
  #     expect(result).to_not include(1,2,3,4)
  #   end

  #   it "limits the returned Instagram posts count to 30" do
  #     result = Gram.whatsnew(1)
  #     expect(result.count).to eq(30)
  #   end

  #   it "returns posts in descending order" do

  #   end


  #   context "there are no new posts" do
  #     it "returns an empty array" do
  #     end
  #   end

  # end WE REALIZED THAT WE"RE WRITING UNNECCESARY SPECS BECAUSE THE GEM IS GONNA HANDLE THEM.
  # ** SAD TROMBONE **
end
