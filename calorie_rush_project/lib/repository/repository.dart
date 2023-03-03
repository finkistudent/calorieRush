import 'package:calorie_rush_project/model/recipe.dart';
import 'package:calorie_rush_project/viewModel/network/recipes_api.dart';


class RecipeRepository {
  RecipesApiProvider _recipesApiProvider = RecipesApiProvider();

  Future<List<Recipe>> fetchRepicesByName(String name) =>
      _recipesApiProvider.fetchRecipesByName(name);
}