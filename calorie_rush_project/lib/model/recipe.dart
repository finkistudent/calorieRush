class Recipe {
  String name;
  String description;
  String image;
  List<String> healthLabels;
  bool isFavorite;

  Recipe(
      {required this.name,
      required this.description,
      required this.image,
      required this.healthLabels,
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

    return Recipe(
      name: json['label'],
      description: desc,
      healthLabels: labels,
      image: json['image'] ?? alternativeImageUrl,
    );
  }

  static List<Recipe> recipesFromSnapshot(List snapshot) {
    return snapshot.map((data) {
      return Recipe.fromJson(data);
    }).toList();
  }
}
