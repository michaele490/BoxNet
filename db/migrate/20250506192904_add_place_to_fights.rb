class AddPlaceToFights < ActiveRecord::Migration[7.2]
  def change
    add_column :fights, :city, :string
    add_column :fights, :country, :string
  end
end
