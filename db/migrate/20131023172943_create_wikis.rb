class CreateWikis < ActiveRecord::Migration
  def change
    create_table :wikis do |t|
      t.string :title
      t.boolean :public
      t.integer :user_id

      t.timestamps
    end
  end
end
