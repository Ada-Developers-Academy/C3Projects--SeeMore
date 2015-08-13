class Post < ActiveRecord::Base
  # Associations ---------------------------------------------------------------
  belongs_to :feed

  # Validations---------------------------------------------
  validates :description, :content, :date_posted, :feed_id, presence: true

  # Scopes ---------------------------------------------------------------------
  scope :chronological, -> { order("date_posted DESC") }
  scope :only_thirty, -> { chronological.limit(30) }

  def short_description
    description.first(425)
  end
end
