class Car < ApplicationRecord
  validates :model, :power, :weight, :fuel_capacity, :fuel_consumption_per_lap, presence: true
end
