class AddAccessLevelToCollaborators < ActiveRecord::Migration
  def change
    add_column :users_wikis, :access_level, :integer, default: 0
  end
end
