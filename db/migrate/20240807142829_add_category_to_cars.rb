class AddCategoryToCars < ActiveRecord::Migration[7.1]
  def change
    add_column :cars, :category, :string
  end
end
