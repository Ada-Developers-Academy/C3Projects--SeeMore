class Post < ActiveRecord::Base
  # Associations ---------------------------------------------------------------
  belongs_to :feed

  # Validations---------------------------------------------
  validates :description, :content, :date_posted, :feed_id, presence: true

  # Scopes ---------------------------------------------------------------------
  scope :chronological, -> { order("date_posted DESC") }
  scope :only_thirty, -> { chronological.limit(30) }
  # scope :paginate, -> (page_number=1) { paginating magic here? }
  # TODO: consider putting chronological's actual code into only_thirty after
  # addressing below comment re: pagination
  # OPTIMIZE: maybe we should account for pagination? we would need something
  # like next_thirty(which_page_number_we_want)
end
