class CreateWikisAndUsers < ActiveRecord::Migration
  def change
    create_table :users_wikis do |t|
      t.belongs_to :user
      t.belongs_to :wiki
    end
  end
end
