require 'spec_helper'

describe RecipesController do
  let!(:recipe) { Recipe.create(:owner_id => 1, :name => 'Twinkies', :cook_time => 20, :servings => 2, :instructions => 'Open and eat.') }

  describe "index" do
    it "should retrieve all recipes" do
      get :index
      assigns(:recipes).should == [recipe]
    end
    
    it "should render the index view" do
      get :index
      response.should render_template(:index)
    end
  end
  
  describe "show" do
    it "should retrieve a recipe" do
      get :show, :id => recipe.id
      assigns(:recipe).should == recipe
    end
    
    it "should render the show view" do
      get :show, :id => recipe.id
      response.should render_template(:show)
    end
  end
  
  describe "new" do
    it "should instantiate a recipe" do
      get :new
      assigns(:recipe).should be_new_record
    end
    
    it "should render the new view" do
      get :new
      response.should render_template(:new)
    end
  end
  
  describe "create" do
    context "with valid params" do
      let(:valid_params) { { :recipe => { :owner_id => 1, :name => 'Bon Bon', :cook_time => 5, :servings => 2, :instructions => 'Open and eat.'} } }
      
      it "should create a recipe with the given params" do
        post :create, valid_params
        assigns(:recipe).should == Recipe.find_by_name('Bon Bon')
      end
    
      it "should save the recipe" do
        post :create, valid_params
        assigns(:recipe).should be_persisted
      end
      
      it "should set the flash success message" do
        post :create, valid_params
        flash[:success].should be_present
      end
    end
    
    context "with invalid params" do
      let(:invalid_params) { { :recipe => { :name => ''} } }
      
      it "should render the new view" do
        post :create, invalid_params
        response.should render_template(:new)
      end
    end
  end
  
  describe "edit" do
    it "should retrieve a recipe" do
      get :edit, :id => recipe.id
      assigns(:recipe).should == recipe
    end
  end
  
  describe "update" do
    context "with valid params" do
      let(:valid_params) { { :id => recipe.id, :recipe => { :owner_id => 1, :name => 'Ho Ho', :cook_time => 15, :servings => 2, :instructions => 'Open and eat.'} } }
      
      it "should update the recipe with the given params" do
        put :update, valid_params
        assigns(:recipe).name.should == 'Ho Ho'
      end
      
      it "should set the flash success message" do
        put :update, valid_params
        flash[:success].should be_present
      end
      
      it "should redirect to the show page" do
        put :update, valid_params
        response.should redirect_to(recipe_url(assigns(:recipe)))
      end
    end
    
    context "with invalid params" do
      let(:invalid_params) { { :id => recipe.id, :recipe => { :name => ''} } }
      
      it "should render the edit view" do
        put :update, invalid_params
        response.should render_template(:edit)
      end
    end
  end
  
  describe "destroy" do
    it "should retrieve a recipe" do
      delete :destroy, :id => recipe.id
      assigns(:recipe).should == recipe
    end
    
    it "should set the flash success message" do
      delete :destroy, :id => recipe.id
      flash[:success].should be_present
    end
    
    it "should redirect to the index page" do
      delete :destroy, :id => recipe.id
      response.should redirect_to(recipes_url)
    end
    
    it "should render the index if the destroy fails" do
      Recipe.any_instance.stub(:destroy => false)
      delete :destroy, :id => recipe.id
      response.should render_template(:index)
    end
  end
end