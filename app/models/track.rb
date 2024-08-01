class Track < ApplicationRecord
  validates :name, :length, :number_of_curves, :car_lap_time, presence: true
end
