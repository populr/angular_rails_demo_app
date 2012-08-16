require 'spec_helper'

describe Recipe do

  describe "attributes" do
    let(:recipe) { Recipe.new }

    %w(name name= cook_time cook_time= servings servings= instructions instructions= photo photo= recipe_ingredients ingredients owner).each do |meth|
      it "should respond to #{meth}" do
        recipe.should respond_to(meth.to_sym)
      end
    end
  end

  describe "validations" do
    it { should validate_presence_of :owner_id }
    it { should validate_presence_of :name }
    it { should validate_presence_of :cook_time }
    it { should validate_presence_of :servings }
    it { should validate_presence_of :instructions }
  end

end