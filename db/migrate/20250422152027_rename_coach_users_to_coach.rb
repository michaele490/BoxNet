class RenameCoachUsersToCoach < ActiveRecord::Migration[7.2]
  def change
    rename_table :coach_users, :coaches
  end
end
