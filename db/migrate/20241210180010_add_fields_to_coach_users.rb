class AddFieldsToCoachUsers < ActiveRecord::Migration[7.2]
  def change
    add_column :coach_users, :first_name, :string
    add_column :coach_users, :last_name, :string
    add_column :coach_users, :username, :string
  end
end
