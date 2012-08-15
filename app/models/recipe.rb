class Recipe < ActiveRecord::Base
  attr_accessible :photo
  
  has_many :recipe_ingredients
  has_many :ingredients, :through => :recipe_ingredients
  has_attached_file :photo
end