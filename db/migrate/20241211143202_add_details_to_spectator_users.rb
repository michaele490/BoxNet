class AddDetailsToSpectatorUsers < ActiveRecord::Migration[7.2]
  def change
    add_column :spectator_users, :first_name, :string
    add_column :spectator_users, :last_name, :string
    add_column :spectator_users, :username, :string
    add_index :spectator_users, :username, unique: true
  end
end
