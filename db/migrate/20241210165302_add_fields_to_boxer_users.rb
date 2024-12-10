class AddFieldsToBoxerUsers < ActiveRecord::Migration[7.2]
  def change
    add_column :boxer_users, :first_name, :string
    add_column :boxer_users, :last_name, :string
    add_column :boxer_users, :username, :string
  end
end
