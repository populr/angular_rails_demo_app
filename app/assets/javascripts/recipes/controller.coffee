@RecipesCtrl = ($scope, $location, Recipe, Ingredient) ->
  $scope.recipes = Recipe.index({})
  $scope.recipe = null
  $scope.recipeFormVisible = false
  $scope.existing_ingredients = []


  Ingredient.index (ingredients) ->
    $scope.existing_ingredients = _(ingredients).map (ingredient) ->
      ingredient.name


  $scope.save = () ->
    if $scope.recipe.unsavedRecipe
      $scope.recipe = new Recipe($scope.recipe)
      $scope.recipe.$create {}, () ->
        if !$scope.recipe.errors?
          $scope.hideRecipeForm()
          $scope.recipes.push($scope.recipe)
    else
      $scope.recipe.$update { id: $scope.recipe.id }, () ->
        $scope.hideRecipeForm() unless $scope.recipe.errors?


  $scope.edit = (recipe) ->
    $scope.recipe = recipe
    $scope.showRecipeForm()


  $scope.newRecipe = () ->
    $scope.recipe = { unsavedRecipe: true }
    $scope.showRecipeForm()


  $scope.showRecipeForm = () ->
    $scope.ingredients = Ingredient.index({})
    $scope.recipeFormVisible = true


  $scope.hideRecipeForm = () ->
    $scope.recipeFormVisible = false


@RecipesCtrl.$inject = ['$scope', '$location', 'Recipe', 'Ingredient']
