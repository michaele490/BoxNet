class AddCoachToBoxer < ActiveRecord::Migration[7.2]
  def change
    add_reference :boxers, :coach, foreign_key: true
  end
end
