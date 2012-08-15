require 'spec_helper'

describe Recipe do
  let(:recipe) { Recipe.new }
  
  it "should respond to name" do
    recipe.should respond_to(:name)
  end

  it "should respond to name=" do
    recipe.should respond_to(:name=)
  end

  it "should respond to cook_time" do
    recipe.should respond_to(:cook_time)
  end

  it "should respond to cook_time=" do
    recipe.should respond_to(:cook_time=)
  end

  it "should respond to servings" do
    recipe.should respond_to(:servings)
  end

  it "should respond to servings=" do
    recipe.should respond_to(:servings=)
  end

  it "should respond to instructions" do
    recipe.should respond_to(:instructions)
  end

  it "should respond to instructions=" do
    recipe.should respond_to(:instructions=)
  end

  it "should respond to photo" do
    recipe.should respond_to(:photo)
  end

  it "should respond to photo=" do
    recipe.should respond_to(:photo=)
  end

  it "should respond to recipe_ingredients" do
    recipe.should respond_to(:recipe_ingredients)
  end

  it "should respond to ingredients" do
    recipe.should respond_to(:ingredients)
  end

end