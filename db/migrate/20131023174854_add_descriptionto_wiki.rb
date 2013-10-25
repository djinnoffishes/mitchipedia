class AddDescriptiontoWiki < ActiveRecord::Migration
  def change
    change_table :wikis do |w|
      w.text :description 
    end
  end
end
