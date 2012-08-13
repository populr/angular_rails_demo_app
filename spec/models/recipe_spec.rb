require 'spec_helper'

describe Recipe, focus: true do

  it "should respond to name" do
    Recipe.new.should respond_to(:name)
  end

  it "should respond to name=" do
    Recipe.new.should respond_to(:name=)
  end

  it "should respond to cook_time" do
    Recipe.new.should respond_to(:cook_time)
  end

  it "should respond to cook_time=" do
    Recipe.new.should respond_to(:cook_time=)
  end

  it "should respond to servings" do
    Recipe.new.should respond_to(:servings)
  end

  it "should respond to servings=" do
    Recipe.new.should respond_to(:servings=)
  end

  it "should respond to instructions" do
    Recipe.new.should respond_to(:instructions)
  end

  it "should respond to instructions=" do
    Recipe.new.should respond_to(:instructions=)
  end

  it "should respond to photo" do
    Recipe.new.should respond_to(:photo)
  end

  it "should respond to photo=" do
    Recipe.new.should respond_to(:photo=)
  end

  it "should respond to recipe_ingredients.new" do
    Recipe.new.should respond_to(:recipe_ingredients.new)
  end

end