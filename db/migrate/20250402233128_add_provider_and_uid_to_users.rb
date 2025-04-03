class AddProviderAndUidToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :provider, :string, default: "email", null: false
    add_column :users, :uid, :string, default: "", null: false
  end
end
