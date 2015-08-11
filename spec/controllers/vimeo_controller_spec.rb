require 'rails_helper'
require 'webmock/rspec'

RSpec.describe VimeoController, type: :controller do
  describe '#call_api' do
    let(:query) { "cupcakes" }
    let(:user) { FactoryGirl.create(:au_user)}
     it "gets a response from an api" do
       VCR.use_cassette "spec/vcr" do
          session[:user_id] = user.id
          get :results, query: query
          expect(assigns(:results).first["name"]).to eq "Cupcake"
       end
     end
  end
end

