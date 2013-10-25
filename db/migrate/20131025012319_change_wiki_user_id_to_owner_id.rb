class ChangeWikiUserIdToOwnerId < ActiveRecord::Migration
  def change
    change_column :wikis, :user_id, :owner_id
  end
end
