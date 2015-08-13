require 'rails_helper'

RSpec.describe PreyController, type: :controller do
  pending "tests for PreyController#create"
  # flash messages
  # does not create new prey if the prey is already in the db
  # creates a new prey if the prey is not already in the db
  # redirects to root path
  # works for both twitter and instagram

  # describe "prey#create" do
  #   let(:prey) { create(:prey) }
  #
  #   it "does not create a new prey if one is already in the db" do
  #     # prey
  #     post :create, { FactoryGirl.attributes_for(:prey)
  #
  #     expect(Prey.all.count).to eq 1
  #   end
  #
  #   it "creates a new prey if one doesn't already exist" do
  #     build(:prey)
  #     post :create, FactoryGirl.attributes_for(:prey)
  #
  #     expect(Prey.first).to eq prey
  #   end
  #
  #   it "redirects to root path" do
  #
  #   end
  # end

  pending "tests for PreyController#unfollow"
  # flash messages
  # does not delete the prey from the db
  # removes the association
  # redirects to dashboard_path(session[:stalker_id])
  # works for both twitter and instagram

end
