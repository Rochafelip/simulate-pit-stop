class SetDefaultRoleAndAdminInUsers < ActiveRecord::Migration[7.1]
  def change
    change_column_default :users, :role, 0 # Usuário comum
    change_column_default :users, :admin, false # Admin como false
  end
end
