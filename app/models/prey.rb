class Prey < ActiveRecord::Base
  has_and_belongs_to_many :stalkers
  has_many :grams
  has_many :tweets
end
