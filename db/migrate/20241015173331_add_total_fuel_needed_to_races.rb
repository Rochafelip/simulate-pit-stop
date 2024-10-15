class AddTotalFuelNeededToRaces < ActiveRecord::Migration[7.1]
  def change
    add_column :races, :total_fuel_needed, :float
  end
end
