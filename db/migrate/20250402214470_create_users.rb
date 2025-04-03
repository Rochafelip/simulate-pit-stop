class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.references :car, null: false, foreign_key: true
      t.references :track, null: false, foreign_key: true
      t.integer :total_laps
      t.float :fuel_consumption_per_lap
      t.float :average_lap_time
      t.float :total_fuel_needed
      
    end
  end
end
