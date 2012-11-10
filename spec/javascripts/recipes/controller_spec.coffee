#= require recipes/module
#= require recipes/controller

beforeEach module 'recipeModule'

beforeEach () ->
  @addMatchers toEqualData: (expected) ->
    angular.equals @actual, expected

describe "RecipesCtrl", () ->
  ctrl = null
  $rootScope = null
  $httpBackend = null
  $controller = null
  Recipe = null
  Ingredient = null
  single_recipe_data = null
  multiple_recipe_data = null
  asparagus_data = null
  ginger_data = null
  multiple_ingredient_data = null

  beforeEach inject ($injector) ->
    $httpBackend = $injector.get '$httpBackend'
    $rootScope = $injector.get '$rootScope'
    $controller = $injector.get '$controller'
    Recipe = $injector.get 'Recipe'
    Ingredient = $injector.get 'Ingredient'


    asparagus =
      id: 'efg',
      recipe_id: 'abc',
      ingredient_id: 'qrs',
      name: 'asparagus',
      unit: 'lb',
      amount: 1

    ginger =
      id: 'hij',
      recipe_id: 'abc',
      ingredient_id: 'tuv',
      name: 'ginger',
      unit: 'T',
      amount: 0.5

    single_recipe_data =
      id: 'abc'
      owner_id: 'def'
      name: 'Ginger Asparagus'
      cook_time: 600
      servings: 4
      instructions: 'Trim. Mince. Cook'
      recipe_ingredients: [asparagus, ginger]

    multiple_recipe_data = [single_recipe_data]


    asparagus_data =
      id: 'qrs'
      name: 'Asparagus'

    ginger_data =
      id: 'tuv'
      name: 'Ginger'

    multiple_ingredient_data = [asparagus_data, ginger_data]


    ctrl = $rootScope.$new()
    $httpBackend.whenGET('/recipes').respond 200, []
    $httpBackend.whenGET('/recipes/new').respond 200, {}
    $httpBackend.whenPOST('/recipes').respond 200, {}

    $httpBackend.whenGET('/ingredients').respond 200, []

    $controller(RecipesCtrl, { $scope: ctrl, Recipe: Recipe, Ingredient: Ingredient })


  it "should auto-load the index of recipes", () ->
    $httpBackend.expectGET('/recipes').respond 200, multiple_recipe_data
    $controller(RecipesCtrl, {$scope: ctrl, Recipe: Recipe })
    $httpBackend.flush()
    expect(ctrl.recipes).toEqualData multiple_recipe_data

  describe "#newRecipe", () ->
    it "should call $scope.showRecipeForm", () ->
      spyOn(ctrl, 'showRecipeForm')
      ctrl.newRecipe()
      expect(ctrl.showRecipeForm).toHaveBeenCalled()

    it "should assign $scope.recipe to a new object with an unsavedRecipe attribute set to true", () ->
      expect(ctrl.recipe).toBeNull()
      ctrl.newRecipe()
      expect(ctrl.recipe).toEqualData { unsavedRecipe: true }

  describe "#edit", () ->
    recipe = null

    beforeEach () ->
      recipe = Recipe.create({})
      $httpBackend.flush()

    it "should set $scope.recipe to the recipe", () ->
      expect(ctrl.recipe).toBeNull()
      ctrl.edit(recipe)
      expect(ctrl.recipe).toEqualData(recipe)

    it "should call $scope.showRecipeForm", () ->
      spyOn(ctrl, 'showRecipeForm')
      ctrl.edit(recipe)
      expect(ctrl.showRecipeForm).toHaveBeenCalled()


  describe "#save an existing recipe", () ->
    recipe = null

    beforeEach () ->
      recipe = Recipe.create(single_recipe_data)

    it "should save changes to the server", () ->
      $httpBackend.expectPUT('/recipes/abc').respond 200
      ctrl.edit(recipe)
      ctrl.save()
      $httpBackend.flush()

    describe "when validation passes", () ->
      it "should hide the recipe form", () ->
        spyOn(ctrl, 'hideRecipeForm')
        $httpBackend.expectPUT('/recipes/abc').respond 200, single_recipe_data
        ctrl.edit(recipe)
        ctrl.save()
        $httpBackend.flush()
        expect(ctrl.hideRecipeForm).toHaveBeenCalled()

    describe "when validation errors exist", () ->
      it "should not hide the recipe form", () ->
        spyOn(ctrl, 'hideRecipeForm')
        single_recipe_data.errors =
          title: ["can't be blank"]
        $httpBackend.expectPUT('/recipes/abc').respond 200, single_recipe_data
        ctrl.edit(recipe)
        ctrl.save()
        $httpBackend.flush()
        expect(ctrl.hideRecipeForm).not.toHaveBeenCalled()

  describe "#save a new recipe", () ->
    beforeEach () ->
      $httpBackend.whenPOST('/recipes').respond 200, single_recipe_data
      ctrl.newRecipe()

    it "should attempt to create a new recipe on the server", () ->
      $httpBackend.expectPOST('/recipes').respond 200, single_recipe_data
      ctrl.save()
      $httpBackend.flush()

    describe "when validation passes", () ->
      it "should hide the recipe form", () ->
        spyOn(ctrl, 'hideRecipeForm')
        ctrl.save()
        $httpBackend.flush()
        expect(ctrl.hideRecipeForm).toHaveBeenCalled()

      it "should add the newly created recipe to $scope.recipes", () ->
        expect(ctrl.recipes.length).toEqual(0)
        ctrl.save()
        $httpBackend.flush()
        expect(ctrl.recipes.length).toEqual(1)

    describe "when validation errors exist", () ->
      beforeEach () ->
        single_recipe_data.errors =
          title: ["can't be blank"]
        $httpBackend.expectPOST('/recipes').respond 200, single_recipe_data

      it "should not hide the recipe form", () ->
        expect(ctrl.recipeFormVisible).toBe(true)
        ctrl.save()
        $httpBackend.flush()
        expect(ctrl.recipeFormVisible).toBe(true)

      it "should not add the newly created recipe to $scope.recipes", () ->
        expect(ctrl.recipes.length).toEqual(0)
        ctrl.save()
        $httpBackend.flush()
        expect(ctrl.recipes.length).toEqual(0)

  describe "#showRecipeForm", () ->
    it "should set ctrl.recipeFormVisible to true", () ->
      ctrl.recipeFormVisible = false
      ctrl.showRecipeForm()
      expect(ctrl.recipeFormVisible).toBe(true)

    it "should fetch the master list of ingredients", () ->
      $httpBackend.expectGET('/ingredients').respond 200, multiple_ingredient_data
      ctrl.showRecipeForm()
      $httpBackend.flush()

  describe "#hideRecipeForm", () ->
    it "should set ctrl.recipeFormVisible to false", () ->
      ctrl.recipeFormVisible = true
      ctrl.hideRecipeForm()
      expect(ctrl.recipeFormVisible).toBe(false)

