class CreateRaces < ActiveRecord::Migration[7.1]
  def change
    create_table :races do |t|
      t.references :track, null: false, foreign_key: true
      t.references :car, null: false, foreign_key: true
      t.float :average_lap_time
      t.float :fuel_consumption_per_lap
      t.integer :total_laps

      t.timestamps
    end
  end
end
