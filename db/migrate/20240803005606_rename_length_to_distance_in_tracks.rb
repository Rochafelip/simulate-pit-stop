class RenameLengthToDistanceInTracks < ActiveRecord::Migration[7.1]
  def change
    rename_column :tracks, :length, :distance
    change_column :tracks, :distance, :float
  end
end
