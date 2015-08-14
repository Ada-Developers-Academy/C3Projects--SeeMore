class InstagramPost < ActiveRecord::Base
  # Associations -----------
  belongs_to :instagram
  has_many :users, through: :instagram

  # Validations -----------
  validates :post_id, :posted_at, :post_url, presence: true, uniqueness: true
  validates :instagram_id, :image_url, presence: true

end
