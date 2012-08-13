require 'spec_helper'

describe RecipeIngredient, focus: true do

  it "should respond to unit" do
    RecipeIngredient.new.should respond_to(:unit)
  end

  it "should respond to unit=" do
    RecipeIngredient.new.should respond_to(:unit=)
  end

  it "should respond to amount" do
    RecipeIngredient.new.should respond_to(:amount)
  end

  it "should respond to amount=" do
    RecipeIngredient.new.should respond_to(:amount=)
  end

end

