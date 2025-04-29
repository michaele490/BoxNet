class AddWeigthClassToBoxers < ActiveRecord::Migration[7.2]
  def change
    add_column :boxers, :weight_class, :string
  end
end
