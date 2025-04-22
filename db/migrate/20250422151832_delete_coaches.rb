class DeleteCoaches < ActiveRecord::Migration[7.2]
  def change
    drop_table :coaches
  end
end
