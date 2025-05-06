class CreateFights < ActiveRecord::Migration[7.2]
  def change
    create_table :fights do |t|
      t.integer :boxer_a_id
      t.integer :boxer_b_id
      t.date :fight_date
      t.string :location
      t.string :weight_class
      t.integer :winner_id
      t.string :method
      t.string :status
      t.boolean :draw

      t.timestamps
    end
  end
end
