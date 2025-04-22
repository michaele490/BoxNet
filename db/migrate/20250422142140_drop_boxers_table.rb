class DropBoxersTable < ActiveRecord::Migration[7.2]
  def change
    drop_table :boxers
  end
end
