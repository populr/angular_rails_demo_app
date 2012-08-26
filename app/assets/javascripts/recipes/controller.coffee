@RecipesCtrl = ($scope, $location, Recipe) ->
  $scope.recipes = Recipe.index({})
  $scope.recipe = null
  $scope.recipeFormVisible = false

  $scope.save = () ->
    if $scope.recipe.unsavedRecipe
      $scope.recipe = new Recipe($scope.recipe)
      $scope.recipe.$create {}, () ->
        if !$scope.recipe.errors?
          $scope.recipeFormVisible = false
          $scope.recipes.push($scope.recipe)
    else
      $scope.recipe.$update { id: $scope.recipe.id }, () ->
        $scope.recipeFormVisible = false unless $scope.recipe.errors?

  $scope.edit = (recipe) ->
    $scope.recipe = recipe
    $scope.recipeFormVisible = true

  $scope.newRecipe = () ->
    $scope.recipe = { unsavedRecipe: true }
    $scope.recipeFormVisible = true

@RecipesCtrl.$inject = ['$scope', '$location', 'Recipe']
