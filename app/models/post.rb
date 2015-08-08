class Post < ActiveRecord::Base
  # Validations ----------------------------------------------------------------
  validates :followee_id, :source, :native_created_at, :native_id, presence: true

  # Associations ---------------------------------------------------------------
  belongs_to :followee

  # Scopes ---------------------------------------------------------------------
  scope :sort, -> { order('native_created_at')}
end
