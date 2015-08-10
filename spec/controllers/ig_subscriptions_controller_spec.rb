require 'rails_helper'
require 'support/vcr_setup'

RSpec.describe IgSubscriptionsController, type: :controller do

  # will need to refactor using this setup for VCR use- only
  # for tests that will hit the API
  # VCR.use_cassette('whatever cassette name you want') do
  #    # the body of the test would go here...
  # end

end
