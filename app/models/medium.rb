class Medium < ActiveRecord::Base
  belongs_to :post

  validates :post_id, :url, presence: true
end
