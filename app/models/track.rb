class Track < ApplicationRecord
  validates :name, presence: true
  validates :length, presence: true
  validates :number_of_curves, presence: true
  validates :car_lap_time, presence: true
end
