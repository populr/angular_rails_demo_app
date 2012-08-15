require 'spec_helper'

describe RecipeIngredient do
  let(:recipe_ingredient) { RecipeIngredient.new }
  
  it "should respond to unit" do
    recipe_ingredient.should respond_to(:unit)
  end

  it "should respond to unit=" do
    recipe_ingredient.should respond_to(:unit=)
  end

  it "should respond to amount" do
    recipe_ingredient.should respond_to(:amount)
  end

  it "should respond to amount=" do
    recipe_ingredient.should respond_to(:amount=)
  end
  
  it "should respond to recipe" do
    recipe_ingredient.should respond_to(:recipe)
  end

  it "should respond to ingredient" do
    recipe_ingredient.should respond_to(:ingredient)
  end

end

