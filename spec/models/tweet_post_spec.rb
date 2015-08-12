require 'rails_helper'

RSpec.describe InstagramPost, type: :model do
  it_behaves_like "a post"
  let(:foreign_key) { :instagram_id }

end
