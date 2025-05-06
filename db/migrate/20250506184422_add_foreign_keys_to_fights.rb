class AddForeignKeysToFights < ActiveRecord::Migration[7.2]
  def change
    add_foreign_key :fights, :boxers, column: :boxer_a_id
    add_foreign_key :fights, :boxers, column: :boxer_b_id
  end
end
