class Race < ApplicationRecord
  belongs_to :track
  belongs_to :car
end
