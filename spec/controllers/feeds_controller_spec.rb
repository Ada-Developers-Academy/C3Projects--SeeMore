require 'rails_helper'

RSpec.describe FeedsController, type: :controller do

describe "GET feeds#search" do

  it "loads the search form" do
    get :search
    expect(response).to render_template(:search)
  end


end

end
