require 'spec_helper'

describe Ingredient, focus: true do

  it "should respond to name" do
    RecipeIngredient.new.should respond_to(:name)
  end

  it "should respond to name=" do
    RecipeIngredient.new.should respond_to(:name=)
  end

end

