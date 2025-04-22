class RenameEditorUsersToEditor < ActiveRecord::Migration[7.2]
  def change
    rename_table :editor_users, :editors
  end
end
