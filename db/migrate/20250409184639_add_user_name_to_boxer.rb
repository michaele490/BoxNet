class AddUserNameToBoxer < ActiveRecord::Migration[7.2]
  def change
    add_column :boxers, :username, :string
  end
end
