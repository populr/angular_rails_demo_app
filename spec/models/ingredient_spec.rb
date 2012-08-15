require 'spec_helper'

describe Ingredient do
  let(:ingredient) { Ingredient.new }
  
  it "should respond to name" do
    ingredient.should respond_to(:name)
  end

  it "should respond to name=" do
    ingredient.should respond_to(:name=)
  end

  it "should respond to recipe_ingredients" do
    ingredient.should respond_to(:recipe_ingredients)
  end

  it "should respond to recipes" do
    ingredient.should respond_to(:recipes)
  end

end

