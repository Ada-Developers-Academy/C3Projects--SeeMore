class Instagram < ActiveRecord::Base
  # Associations ----------------------------------------------
  has_and_belongs_to_many :users

  # Validations ----------------------------------------------
  validates :username, :provider_id, presence: true, uniqueness: true

  # Methods ----------------------------------------------
  def self.search(query)
    where("username like ?", "%#{query}%")
  end

end
