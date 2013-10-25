class CreateCollaborators < ActiveRecord::Migration
  def change
    create_table :collaborators, id: false do |t|
      t.integer :wiki_id, null: false
      t.integer :user_id, null: false
    end
  add_index :collaborators, :wiki_id
  add_index :collaborators, :user_id
  add_index :collaborators, [ :wiki_id, :user_id ]
  end
end
