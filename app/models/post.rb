class Post < ActiveRecord::Base
  # Associations ---------------------------------------------------------------
  belongs_to :feed

  # Validations ----------------------------------------------------------------
  validates_presence_of :feed_id

  # Scopes ---------------------------------------------------------------------
  scope :chronological, -> { order("date_posted DESC")}
  scope :only_thirty, -> { limit(30) }
end
