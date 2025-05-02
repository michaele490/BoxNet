class AddStaminaToBoxers < ActiveRecord::Migration[7.2]
  def change
    add_column :boxers, :stamina, :integer
  end
end
