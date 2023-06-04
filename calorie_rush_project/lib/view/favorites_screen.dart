import 'package:calorie_rush_project/view/details.dart';
import 'package:flutter/material.dart';
import 'package:calorie_rush_project/model/recipe.dart';

class FavoritesScreen extends StatelessWidget {
  final List<Recipe> favoriteRecipes;
  final Function toggleFavorite;

  const FavoritesScreen({
    Key? key,
    required this.favoriteRecipes,
    required this.toggleFavorite,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorite Recipes'),
      ),
      body: favoriteRecipes.isEmpty
          ? Center(
              child: Text(
                'No favorite recipes.',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          : ListView.builder(
              itemCount: favoriteRecipes.length,
              itemBuilder: (context, index) {
                Recipe recipe = favoriteRecipes[index];
                return ListTile(
                  title: Text(
                    recipe.name,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                      color: Colors.black,
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RecipeScreen(recipe: recipe),
                      ),
                    );
                  },
                  trailing: IconButton(
                    icon: Icon(
                      Icons.favorite,
                      color: Colors.pinkAccent,
                      size: 30,
                    ),
                    onPressed: () => toggleFavorite(recipe),
                  ),
                );
              },
            ),
    );
  }
}
