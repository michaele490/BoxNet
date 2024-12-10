class CreateBoxers < ActiveRecord::Migration[7.2]
  def change
    create_table :boxers do |t|
      t.integer :overall_rating
      t.integer :defence
      t.integer :power
      t.integer :speed
      t.integer :iq
      t.references :boxer_user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
