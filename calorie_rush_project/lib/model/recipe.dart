class Recipe {
  String name;
  String description;
  String image;
  List<String> healthLabels;
  double quantity;
  double fatQuantity;
  double sugarQuantity;
  double carbsQuantity;
  double proteinQuantity;
  double cholesterolQuantity;
  double sodiumQuantity;
  double calciumQuantity;
  double magnesiumQuantity;
  double ironQuantity;
  bool isFavorite;

  Recipe(
      {required this.name,
      required this.description,
      required this.image,
      required this.healthLabels,
      required this.quantity,
      required this.fatQuantity,
      required this.sugarQuantity,
      required this.carbsQuantity,
      required this.proteinQuantity,
      required this.cholesterolQuantity,
      required this.sodiumQuantity,
      required this.calciumQuantity,
      required this.magnesiumQuantity,
      required this.ironQuantity,
      this.isFavorite = false});

  factory Recipe.fromJson(Map<String, dynamic> json) {
    var alternativeImageUrl =
        "https://helloartsy.com/wp-content/uploads/kids/food/how-to-draw-chopsticks/how-to-draw-chopsticks-step-6-1024x1024.jpg";

    String desc = "";
    for (var l in json['ingredientLines']) {
      desc = desc += "\n$l";
    }

    List<String> labels = [];
    for (String label in json['healthLabels']) {
      labels.add(label);
    }

    double getQuantity(Map<String, dynamic> json, String nutrientLabel) {
      if (json['totalNutrients'] != null &&
          json['totalNutrients'][nutrientLabel] != null &&
          json['totalNutrients'][nutrientLabel]['quantity'] != null) {
        return json['totalNutrients'][nutrientLabel]['quantity'].toDouble();
      }
      return 0.0;
    }

    return Recipe(
      name: json['label'],
      description: desc,
      healthLabels: labels,
      image: json['image'] ?? alternativeImageUrl,
      quantity: json['totalNutrients']['ENERC_KCAL']['quantity'],
      fatQuantity: getQuantity(json, 'FAT'),
      sugarQuantity: getQuantity(json, 'SUGAR'),
      carbsQuantity: getQuantity(json, 'CHOCDF'),
      proteinQuantity: getQuantity(json, 'PROCNT'),
      cholesterolQuantity: getQuantity(json, 'CHOLE'),
      sodiumQuantity: getQuantity(json, 'NA'),
      calciumQuantity: getQuantity(json, 'CA'),
      magnesiumQuantity: getQuantity(json, 'MG'),
      ironQuantity: getQuantity(json, 'FE')
    );
  }

  static List<Recipe> recipesFromSnapshot(List snapshot) {
    return snapshot.map((data) {
      return Recipe.fromJson(data);
    }).toList();
  }
}
