class Post < ActiveRecord::Base
  # Associations ---------------------------------------------------------------
  belongs_to :feed

  # Validations ----------------------------------------------------------------
  validates_presence_of :feed_id

  # Scopes ---------------------------------------------------------------------
  scope :chronological, -> { order("date_posted DESC") }
  scope :only_thirty, -> { chronological.limit(30) }
  # TODO: consider putting chronological's actual code into only_thirty after
  # addressing below comment re: pagination
  # OPTIMIZE: maybe we should account for pagination? we would need something
  # like next_thirty(which_page_number_we_want)
end
