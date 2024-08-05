class CreateTracks < ActiveRecord::Migration[7.1]
  def change
    create_table :tracks do |t|
      t.string :name
      t.float :distance
      t.integer :number_of_curves
      t.string :country
      t.float :elevation_track

      t.timestamps
    end
  end
end
