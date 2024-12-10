class CreateCoaches < ActiveRecord::Migration[7.2]
  def change
    create_table :coaches do |t|
      t.references :coach_user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
