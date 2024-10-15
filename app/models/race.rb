class Race < ApplicationRecord
  before_save :calculate_total_fuel_needed

  belongs_to :car
  belongs_to :track

  validates :car_id, presence: true
  validates :track_id, presence: true
  validates :average_lap_time, numericality: { greater_than: 0 }
  validates :fuel_consumption_per_lap, numericality: { greater_than: 0 }
  validates :total_laps, numericality: { greater_than: 0 }
  validates :total_fuel_needed, numericality: { greater_than_or_equal_to: 0 }

  private

  def calculate_total_fuel_needed
    self.total_fuel_needed = fuel_consumption_per_lap * total_laps
  end
end
