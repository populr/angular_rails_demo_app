class CreateRecipeIngredients < ActiveRecord::Migration
  def change
    create_table :recipe_ingredients do |t|
      t.string :unit, :null => false
      t.float :amount, :null => false
      t.integer :recipe_id, :null => false
      t.integer :ingredient_id, :null => false

      t.timestamps
    end
  end
end
