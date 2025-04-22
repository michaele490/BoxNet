class RemoveCoachUserFromBoxers < ActiveRecord::Migration[7.2]
  def change
    remove_reference :boxers, :coach_user, foreign_key: true, index: true
  end
end
