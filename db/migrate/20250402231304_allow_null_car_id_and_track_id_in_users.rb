class AllowNullCarIdAndTrackIdInUsers < ActiveRecord::Migration[7.1]
  def change
    change_column_null :users, :car_id, true
    change_column_null :users, :track_id, true
  end
end
