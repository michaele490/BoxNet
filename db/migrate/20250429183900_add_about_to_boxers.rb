class AddAboutToBoxers < ActiveRecord::Migration[7.2]
  def change
    add_column :boxers, :nickname, :string
    add_column :boxers, :nationality, :string
    add_column :boxers, :gender, :string
  end
end
