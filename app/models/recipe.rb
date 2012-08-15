class Recipe < ActiveRecord::Base
  attr_accessible :owner_id, :name, :cook_time, :servings, :instructions, :photo
  
  belongs_to :owner, :class_name => 'User'
  has_many :recipe_ingredients
  has_many :ingredients, :through => :recipe_ingredients
  has_attached_file :photo
  
  validates :owner_id, :name, :cook_time, :servings, :instructions, :presence => true
end