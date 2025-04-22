class AddBoxerAttributesToBoxerUsers < ActiveRecord::Migration[7.2]
  def change
    add_column :boxer_users, :overall_rating, :integer
    add_column :boxer_users, :defence, :integer
    add_column :boxer_users, :power, :integer
    add_column :boxer_users, :speed, :integer
    add_column :boxer_users, :iq, :integer
  end
end
