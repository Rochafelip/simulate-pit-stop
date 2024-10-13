class Car < ApplicationRecord
  has_many :races
  
  validates :model, presence: true
  validates :power, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :weight, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :fuel_capacity, presence: true, numericality: { greater_than: 0 }
end
