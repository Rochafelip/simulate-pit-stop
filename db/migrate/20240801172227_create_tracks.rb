class CreateTracks < ActiveRecord::Migration[7.1]
  def change
    create_table :tracks do |t|
      t.string :name
      t.integer :length
      t.integer :number_of_curves
      t.float :car_lap_time

      t.timestamps
    end
  end
end
