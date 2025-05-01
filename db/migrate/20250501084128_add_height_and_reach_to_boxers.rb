class AddHeightAndReachToBoxers < ActiveRecord::Migration[7.2]
  def change
    add_column :boxers, :height, :float
    add_column :boxers, :reach, :float
  end
end
