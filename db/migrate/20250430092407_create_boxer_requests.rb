class CreateBoxerRequests < ActiveRecord::Migration[7.2]
  def change
    create_table :boxer_requests do |t|
      t.references :coach, null: false, foreign_key: true
      t.references :boxer, null: false, foreign_key: true
      t.integer :status, default: 0, null: false

      t.timestamps
    end

    add_index :boxer_requests, [:coach_id, :boxer_id], unique: true
  end
end
