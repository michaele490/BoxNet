class RenameBoxerUsersToBoxers < ActiveRecord::Migration[7.2]
  def change
    rename_table :boxer_users, :boxers
  end
end
