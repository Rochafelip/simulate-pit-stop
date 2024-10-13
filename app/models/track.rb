class Track < ApplicationRecord
  has_many :races
  
  validates :name, presence: true
  validates :distance, presence: true, numericality: { greater_than: 0 }
  validates :number_of_curves, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :country, presence: true
  validates :elevation_track, numericality: { greater_than_or_equal_to: 0 }, allow_nil: true
end
