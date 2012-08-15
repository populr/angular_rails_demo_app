class RecipesController < ApplicationController
  before_filter :load_record, :only => [:show, :edit, :update, :destroy]
  def index
    @recipes = Recipe.all
  end
  
  def show
    
  end
  
  def new
    @recipe = Recipe.new
  end
  
  def create
    @recipe = Recipe.create(params[:recipe])
    if @recipe.save
      flash[:success] = "The recipe was successfully saved."
      redirect_to recipe_url(@recipe)
    else
      render :new
    end
  end
  
  def edit
    
  end
  
  def update
    if @recipe.update_attributes(params[:recipe])
      flash[:success] = "The recipe was successfully updated."
      redirect_to recipe_url(@recipe)
    else
      render :edit
    end
  end
  
  def destroy
    if @recipe.destroy
      flash[:success] = "The recipe was successfully deleted."
      redirect_to recipes_url
    else
      render :index
    end
  end
  
  private
  def load_record
    @recipe = Recipe.find(params[:id])
  end
end