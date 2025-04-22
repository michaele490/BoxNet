class RenameSpectatorUsersToSpectator < ActiveRecord::Migration[7.2]
  def change
    rename_table :spectator_users, :spectators
  end
end
