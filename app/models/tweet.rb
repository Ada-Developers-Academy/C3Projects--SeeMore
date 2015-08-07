class Tweet < ActiveRecord::Base
  validates :tw_user_id_str, :tw_created_at, :tw_text, :user_id, presence: true
  validates :tw_id_str, presence: true, uniqueness: true
end
