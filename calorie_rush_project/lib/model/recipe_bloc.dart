// import 'package:calorie_rush_project/model/recipe.dart';
// // import 'package:rxdart/rxdart.dart';
//
// class RecipeBloc {
//   final _recipes = BehaviorSubject<List<Recipe>>.seeded([]);
//   final _favoriteRecipes = BehaviorSubject<List<Recipe>>.seeded([]);
//
//   Stream<List<Recipe>> get recipes => _recipes.stream;
//
//   Stream<List<Recipe>> get favoriteRecipes => _favoriteRecipes.stream;
//
//   Function(List<Recipe>) get setRecipes => _recipes.sink.add;
//
//   Function(List<Recipe>) get setFavoriteRecipes => _favoriteRecipes.sink.add;
//
//   void toggleFavorite(Recipe recipe) {
//     var favorites = _favoriteRecipes.value;
//     if (favorites.contains(recipe)) {
//       favorites.remove(recipe);
//     }
//     else {
//       favorites.add(recipe);
//     }
//     setFavoriteRecipes(favorites);
//   }
//
//   void dipose() {
//     _recipes.close();
//     _favoriteRecipes.close();
//   }
// }
// final recipeBloc = RecipeBloc();
