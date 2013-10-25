class AddIndexingToWikis < ActiveRecord::Migration
  def change
    add_index :wikis, :user_id
  end
end
