import 'package:calorie_rush_project/model/recipe.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RecipesApiProvider {
  static var uri = "https://api.edamam.com/api/recipes/v2?type=public&q=m&app_id=013b4faf&app_key=030959077364a664b34c191cd3a687fd&fbclid=IwAR3RoTSrreI3W31uu1mI7uQ-1bee1h5o1HxGUYGvdtlZ6kQqvyLUiBdlgrA";
  final successCode = 200;

  static Future<List<Recipe>> fetchRecipe() async {
    final response = await http.get(Uri.parse(uri));

    Map data = jsonDecode(response.body);
    List _temp = [];

    for (var i in data['hits']) {
      _temp.add(i['recipe']);
    }

    return Recipe.recipesFromSnapshot(_temp);
  }

  List<Recipe> parseResponse(http.Response response) {
    final responseString = jsonDecode(response.body);

    if (response.statusCode == successCode) {
      return responseString;
    } else {
      throw Exception('failed to load players');
    }
  }

  Future<List<Recipe>> fetchRecipesByName(String name) async {
    var response = await fetchRecipe();
    return response.where((element) => element.name == name).toList();
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
          image: url,
          quantity: 0,
          fatQuantity: 0,
          sugarQuantity: 0,
          carbsQuantity: 0,
          proteinQuantity: 0,
          cholesterolQuantity: 0,
          sodiumQuantity: 0,
          calciumQuantity: 0,
          magnesiumQuantity: 0,
          ironQuantity: 0),
      Recipe(
          name: 'Pad Thai',
          description: 'A popular Thai stir-fried noodle dish.',
          healthLabels: [],
          image: url,
          quantity: 0,
          fatQuantity: 0,
          sugarQuantity: 0,
          carbsQuantity: 0,
          proteinQuantity: 0,
          cholesterolQuantity: 0,
          sodiumQuantity: 0,
          calciumQuantity: 0,
          magnesiumQuantity: 0,
          ironQuantity: 0),
      Recipe(
          name: 'Tacos',
          description:
              'A Mexican dish consisting of a tortilla filled with various ingredients.',
          healthLabels: [],
          image: url,
          quantity: 0,
          fatQuantity: 0,
          sugarQuantity: 0,
          carbsQuantity: 0,
          proteinQuantity: 0,
          cholesterolQuantity: 0,
          sodiumQuantity: 0,
          calciumQuantity: 0,
          magnesiumQuantity: 0,
          ironQuantity: 0),
      Recipe(
          name: 'Pizza',
          description:
              'A savory Italian dish that is typically round and flat.',
          healthLabels: [],
          image: url,
          quantity: 0,
          fatQuantity: 0,
          sugarQuantity: 0,
          carbsQuantity: 0,
          proteinQuantity: 0,
          cholesterolQuantity: 0,
          sodiumQuantity: 0,
          calciumQuantity: 0,
          magnesiumQuantity: 0,
          ironQuantity: 0),
    ];
  }
}
