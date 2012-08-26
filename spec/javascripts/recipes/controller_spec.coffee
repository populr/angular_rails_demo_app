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
  single_recipe_data = null
  multiple_recipe_data = null

  beforeEach inject ($injector) ->
    $httpBackend = $injector.get '$httpBackend'
    $rootScope = $injector.get '$rootScope'
    $controller = $injector.get '$controller'
    Recipe = $injector.get 'Recipe'


    single_recipe_data =
      id: 'abc'
      owner_id: 'def'
      name: 'Ginger Asparagus'
      cook_time: 600
      servings: 4
      instructions: 'Trim. Mince. Cook'
      recipe_ingredients: [ { name: 'asparagus', unit: 'lb', amount: 1 }, { name: 'ginger', unit: 'T', amount: 0.5 } ]

    multiple_recipe_data = [single_recipe_data]


    ctrl = $rootScope.$new()
    $httpBackend.whenGET('/recipes').respond 200, []
    $httpBackend.whenGET('/recipes/new').respond 200, {}
    $httpBackend.whenPOST('/recipes').respond 200, {}
    $controller(RecipesCtrl, {$scope: ctrl, Recipe: Recipe })


  it "should auto-load the index of recipes", () ->
    $httpBackend.expectGET('/recipes').respond 200, multiple_recipe_data
    $controller(RecipesCtrl, {$scope: ctrl, Recipe: Recipe })
    $httpBackend.flush()
    expect(ctrl.recipes).toEqualData multiple_recipe_data

  describe "#newRecipe", () ->
    it "should set $scope.recipeFormVisible to true", () ->
      expect(ctrl.recipeFormVisible).toBe(false)
      ctrl.newRecipe()
      expect(ctrl.recipeFormVisible).toBe(true)

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

    it "should set $scope.recipeFormVisible to true", () ->
      expect(ctrl.recipeFormVisible).toBe(false)
      ctrl.edit(recipe)
      expect(ctrl.recipeFormVisible).toBe(true)

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
        $httpBackend.expectPUT('/recipes/abc').respond 200, single_recipe_data
        ctrl.edit(recipe)
        ctrl.save()
        $httpBackend.flush()
        expect(ctrl.recipeFormVisible).toBe(false)

    describe "when validation errors exist", () ->
      it "should not hide the recipe form", () ->
        single_recipe_data.errors =
          title: ["can't be blank"]
        $httpBackend.expectPUT('/recipes/abc').respond 200, single_recipe_data
        ctrl.edit(recipe)
        ctrl.save()
        $httpBackend.flush()
        expect(ctrl.recipeFormVisible).toBe(true)

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
        expect(ctrl.recipeFormVisible).toBe(true)
        ctrl.save()
        $httpBackend.flush()
        expect(ctrl.recipeFormVisible).toBe(false)

      it "should add the newly created recipe to $scope.recipes", () ->
        $httpBackend.expectPOST('/recipes').respond 200, single_recipe_data
        expect(ctrl.recipes.length).toEqual(0)
        ctrl.save()
        $httpBackend.flush()
        expect(ctrl.recipes.length).toEqual(1)

    describe "when validation errors exist", () ->
      beforeEach () ->
        single_recipe_data.errors =
          title: ["can't be blank"]

      it "should not hide the recipe form", () ->
        ctrl.newRecipe()
        ctrl.save()
        $httpBackend.flush()
        expect(ctrl.recipeFormVisible).toBe(true)

      it "should not add the newly created recipe to $scope.recipes", () ->
        $httpBackend.expectPOST('/recipes').respond 200, single_recipe_data
        expect(ctrl.recipes.length).toEqual(0)
        ctrl.save()
        $httpBackend.flush()
        expect(ctrl.recipes.length).toEqual(0)

