import 'package:calorie_rush_project/model/recipe.dart';
import 'package:flutter/material.dart';

class RecipeScreen extends StatelessWidget {
  final Recipe recipe;

  const RecipeScreen({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    List<String> labels = recipe.healthLabels;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          recipe.name,
          style: const TextStyle(color: Colors.white),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 35.0),
            Card(
              shadowColor: Colors.grey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.network(
                      recipe.image,
                      width: 350,
                      height: 200,
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  const Text(
                    'Ingredients list for',
                    style: TextStyle(fontSize: 35, color: Colors.black54),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 10.0),
                  Text(
                    recipe.name,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 35,
                        color: Colors.black54),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    recipe.description,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black54),
                  ),
                  const SizedBox(height: 30.0),
                ],
              ),
            ),
            const SizedBox(height: 30.0),
            Text(
                'This food contains  ${recipe.quantity.toStringAsFixed(2)} kcal.',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.lightGreen,
                )),
          ],
        ),
      ),
    );
  }
}
