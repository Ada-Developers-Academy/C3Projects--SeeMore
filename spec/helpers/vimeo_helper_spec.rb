require 'rails_helper'

RSpec.describe VimeoHelper, type: :helper do
  context "#grab_id" do
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

  context "#resize_video" do
    let(:result_before) {
      '<iframe src="http://website.com/best_video_ever" width="1920"
        height="1080" frameborder="0" title="Best Video Ever"
        webkitallowfullscreen mozallowfullscreen allowfullscreen></iframe>'
    }

    let(:result_after) {
      '<iframe src="http://website.com/best_video_ever" width="100%"
        height="75%" frameborder="0" title="Best Video Ever"
        webkitallowfullscreen mozallowfullscreen allowfullscreen></iframe>'
    }

    let(:no_nested_html_key_hash) {
        JSON.parse({
        "potatoes": "totally a vegetable",
        "something sweet": "not potatoes",
        "embed": {
          "not html": result_before
          }
      }.to_json)
    }

    let(:no_embed_key_hash) {
        JSON.parse({
        "potatoes": "totally a vegetable",
        "something sweet": "not potatoes",
        "not embed": {
          "html": result_before
          }
      }.to_json)
    }

    let(:valid_result_hash) {
      JSON.parse({
        "potatoes": "totally a vegetable",
        "something sweet": "not potatoes",
        "embed": {
          "html": result_before
          }
      }.to_json)
    }

    it "looks for an html key nested inside an embed key" do
      expect{ resize_video(no_nested_html_key_hash) }.to raise_exception(NoMethodError)
      expect{ resize_video(no_embed_key_hash) }.to raise_exception(NoMethodError)
      expect(resize_video(valid_result_hash)).not_to be_nil
    end

    it "changes the height & width of the frame to more responsive values" do
      expect(resize_video(valid_result_hash)).to eq(result_after)
    end
  end
end
