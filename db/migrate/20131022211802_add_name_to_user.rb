class AddNameToUser < ActiveRecord::Migration
  def change
    change_table :users do |u|
      u.string :name 
    end
  end
end
