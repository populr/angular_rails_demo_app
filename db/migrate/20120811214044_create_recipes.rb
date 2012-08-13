class CreateRecipes < ActiveRecord::Migration
  def change
    create_table :recipes do |t|
      t.integer :owner_id, :null => false
      t.string :name, :null => false
      t.integer :cook_time, :null => false
      t.integer :servings, :null => false
      t.text :instructions, :null => false

      t.timestamps
    end

    change_table :recipes do |t|
      t.index :owner_id, :unique => false
    end
  end
end
