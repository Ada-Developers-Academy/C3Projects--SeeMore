require 'rails_helper'

RSpec.describe VimeoHelper, type: :helper do
  let(:invalid_result_hash) {
      JSON.parse({
      "potatoes": "totally a vegetable",
      "something sweet": "not potatoes"
    }.to_json)
  }

  let(:fake_id) {
    "752345789023458072345867"
  }

  let(:valid_result_hash) {
    JSON.parse({
      "potatoes": "totally a vegetable",
      "something sweet": "not potatoes",
      "uri": "/videos/#{ fake_id }"
    }.to_json)
  }

  it "looks for a uri key in a hash" do
    expect{ grab_id(invalid_result_hash) }.to raise_exception(NoMethodError)
    expect(grab_id(valid_result_hash)).not_to be_nil
  end

  it "splits the uri and returns the last item" do
    expect(grab_id(valid_result_hash)).to eq(fake_id)
  end
end
