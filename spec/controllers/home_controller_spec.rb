require 'rails_helper'
require 'support/vcr_setup'

RSpec.describe HomeController, type: :controller do

  # will need to refactor using this setup for VCR use
  # only on tests that would make an API call
  # VCR.use_cassette('whatever cassette name you want') do
  #    # the body of the test would go here...
  # end

end
