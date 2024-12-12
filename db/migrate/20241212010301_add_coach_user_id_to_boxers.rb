class AddCoachUserIdToBoxers < ActiveRecord::Migration[7.2]
  def change
    add_column :boxers, :coach_user_id, :integer
    add_foreign_key :boxers, :coach_users, column: :coach_user_id
    add_index :boxers, :coach_user_id
  end
end
