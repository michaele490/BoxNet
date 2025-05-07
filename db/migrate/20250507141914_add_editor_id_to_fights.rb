class AddEditorIdToFights < ActiveRecord::Migration[7.2]
  def change
    add_column :fights, :editor_id, :integer
  end
end
