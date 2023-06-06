import 'package:calorie_rush_project/model/recipe.dart';
import 'package:flutter/material.dart';

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
            Flexible(
              child: Container(
                padding: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: ListView.builder(
                  itemCount: 6,
                  // Adjust the count based on the actual number of nutrient details
                  itemBuilder: (context, index) {
                    String nutrientLabel = '';
                    String nutrientValue = '';

                    // Assign the appropriate nutrient label and value based on the index
                    switch (index) {
                      case 0:
                        nutrientLabel = 'Energy';
                        nutrientValue =
                        '${recipe.quantity.toStringAsFixed(2)} kcal';
                        break;
                      case 1:
                        nutrientLabel = 'Fat';
                        nutrientValue =
                        '${recipe.fatQuantity.toStringAsFixed(2)} g';
                        break;
                      case 2:
                        nutrientLabel = 'Sugar';
                        nutrientValue =
                        '${recipe.sugarQuantity.toStringAsFixed(2)} g';
                        break;
                      case 3:
                        nutrientLabel = 'Carbs';
                        nutrientValue =
                        '${recipe.carbsQuantity.toStringAsFixed(2)} g';
                        break;
                      case 4:
                        nutrientLabel = 'Protein';
                        nutrientValue =
                        '${recipe.proteinQuantity.toStringAsFixed(2)} g';
                        break;
                      case 5:
                        nutrientLabel = 'Cholesterol';
                        nutrientValue =
                        '${recipe.cholesterolQuantity.toStringAsFixed(2)} mg';
                        break;
                    // Add cases for other nutrient details if needed
                    }

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          nutrientLabel,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.lightGreen,
                          ),
                        ),
                        const SizedBox(height: 10.0),
                        Text(
                          nutrientValue,
                          style: const TextStyle(fontSize: 16),
                        ),
                        const SizedBox(height: 10.0),
                      ],
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
