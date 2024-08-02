class CreateCars < ActiveRecord::Migration[7.1]
  def change
    create_table :cars do |t|
      t.string :model
      t.integer :power
      t.integer :weight
      t.float :fuel_capacity
      t.float :fuel_consumption_per_lap

      t.timestamps
    end
  end
end
