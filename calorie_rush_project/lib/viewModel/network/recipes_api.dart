import 'package:calorie_rush_project/model/recipe.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RecipesApiProvider {
  static var uri = "";

  static Future<List<Recipe>> fetchRecipe() async {
    final response = await http.get(Uri.parse(uri));

    Map data = jsonDecode(response.body);
    List _temp = [];

    for (var i in data['hits']) {
      _temp.add(i['recipe']);
    }

    return Recipe.recipesFromSnapshot(_temp);
  }
}

// Used as a mock data provider
class RecipesListProvider {
  static List<Recipe> getRecipes() {
    var url =
        "https://hips.hearstapps.com/del.h-cdn.co/assets/cm/15/10/54f66b7d1403f_-_chicken-waffle-sliders-food-folds-fun-lgn.jpg?resize=480:*";
    return [
      Recipe(
          name: 'Spaghetti Bolognese',
          description: 'A classic Italian pasta dish.',
          healthLabels: [],
          image: url),
      Recipe(
          name: 'Pad Thai',
          description: 'A popular Thai stir-fried noodle dish.',
          healthLabels: [],
          image: url),
      Recipe(
          name: 'Tacos',
          description:
              'A Mexican dish consisting of a tortilla filled with various ingredients.',
          healthLabels: [],
          image: url),
      Recipe(
          name: 'Pizza',
          description:
              'A savory Italian dish that is typically round and flat.',
          healthLabels: [],
          image: url),
    ];
  }
}
