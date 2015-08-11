require 'rails_helper'

RSpec.describe PreyController, type: :controller do
  pending "tests for PreyController#create"
  # flash messages
  # does not create new prey if the prey is already in the db
  # creates a new prey if the prey is not already in the db
  # redirects to root path
  # works for both twitter and instagram

  pending "tests for PreyController#unfollow"
  # flash messages
  # does not delete the prey from the db
  # removes the association
  # redirects to dashboard_path(session[:stalker_id])
  # works for both twitter and instagram

end
