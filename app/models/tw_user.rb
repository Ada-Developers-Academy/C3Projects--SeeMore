class TwUser < ActiveRecord::Base
  # Associations
  has_and_belongs_to_many :users
  has_many :tweets

  # Validations
  validates :tw_user_id_str, presence: true
end
