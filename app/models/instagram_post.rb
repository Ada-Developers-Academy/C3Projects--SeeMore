class InstagramPost < ActiveRecord::Base
  belongs_to :instagram
  has_many :users, through: :instagram

  # Validations -----------
  validates :post_id, presence: true, uniqueness: true
  validates :instagram_id, presence: true

end
