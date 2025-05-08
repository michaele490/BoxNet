class CreateBoxerRecords < ActiveRecord::Migration[7.2]
  def change
    create_table :boxer_records do |t|
      t.integer :wins
      t.integer :losses
      t.integer :draws
      t.integer :knockout_wins
      t.integer :knockout_losses
      t.references :boxer, null: false, foreign_key: true

      t.timestamps
    end
  end
end
