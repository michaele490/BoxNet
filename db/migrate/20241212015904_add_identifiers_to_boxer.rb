class AddIdentifiersToBoxer < ActiveRecord::Migration[7.2]
  def change
    add_column :boxers, :first_name, :string
    add_column :boxers, :last_name, :string
  end
end
