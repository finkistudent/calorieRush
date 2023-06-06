import 'package:flutter/material.dart';
import 'package:calorie_rush_project/model/recipe.dart';

class RecipeScreen extends StatelessWidget {
  final Recipe recipe;

  const RecipeScreen({Key? key, required this.recipe}) : super(key: key);

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
            Container(
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'This food contains:',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.lightGreen,
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    Text(
                      'Energy: ${recipe.quantity.toStringAsFixed(2)} kcal',
                      style: const TextStyle(fontSize: 16),
                    ),
                    Text(
                      'Fat: ${recipe.fatQuantity.toStringAsFixed(2)} g',
                      style: const TextStyle(fontSize: 16),
                    ),
                    Text(
                      'Sugar: ${recipe.sugarQuantity.toStringAsFixed(2)} g',
                      style: const TextStyle(fontSize: 16),
                    ),
                    Text(
                      'Carbs: ${recipe.carbsQuantity.toStringAsFixed(2)} g',
                      style: const TextStyle(fontSize: 16),
                    ),
                    Text(
                      'Protein: ${recipe.proteinQuantity.toStringAsFixed(2)} g',
                      style: const TextStyle(fontSize: 16),
                    ),
                    Text(
                      'Cholesterol: ${recipe.cholesterolQuantity.toStringAsFixed(2)} mg',
                      style: const TextStyle(fontSize: 16),
                    ),
                    Text(
                      'Sodium: ${recipe.sodiumQuantity.toStringAsFixed(2)} mg',
                      style: const TextStyle(fontSize: 16),
                    ),
                    Text(
                      'Calcium: ${recipe.calciumQuantity.toStringAsFixed(2)} mg',
                      style: const TextStyle(fontSize: 16),
                    ),
                    Text(
                      'Magnesium: ${recipe.magnesiumQuantity.toStringAsFixed(2)} mg',
                      style: const TextStyle(fontSize: 16),
                    ),
                    Text(
                      'Iron: ${recipe.ironQuantity.toStringAsFixed(2)} mg',
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
