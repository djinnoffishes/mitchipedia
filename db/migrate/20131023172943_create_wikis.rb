class CreateWikis < ActiveRecord::Migration
  def change
    create_table :wikis do |t|
      t.string :title
      t.boolean :public
      t.integer :owner_id

      t.timestamps
    end
    add_index :wikis, :owner_id
  end
end
