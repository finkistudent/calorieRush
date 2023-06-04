import 'package:calorie_rush_project/viewModel/network/recipes_api.dart';
import 'package:flutter/material.dart';
import 'model/recipe.dart';
import 'package:calorie_rush_project/view/home.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

void main() {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<Recipe> _recipes = [];
  List<Recipe> favoriteRecipes = [];

  bool _isLoading = true;

  Future<void> fetchRecipes() async {
    _recipes = await RecipesApiProvider.fetchRecipe();
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    FlutterNativeSplash.remove();
    fetchRecipes();
  }

  void toggleFavorite(Recipe recipe) {
    setState(() {
      recipe.isFavorite = !recipe.isFavorite;
      if (recipe.isFavorite) {
        favoriteRecipes.add(recipe);
      } else {
        favoriteRecipes.remove(recipe);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CalorieRush',
      theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch()
              .copyWith(primary: Colors.lightGreen[300])),
      home: MyHomePage(
        isLoading: _isLoading,
        recipes: _recipes,
        favoriteRecipes: favoriteRecipes,
        toggleFavorite: toggleFavorite,
      ),
    );
  }
}
