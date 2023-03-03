import 'package:flutter/material.dart';
import 'package:calorie_rush_project/model/recipe.dart';
import 'details.dart';
import 'package:calorie_rush_project/model/recipe_bloc.dart';
import 'dart:math';
import 'package:calorie_rush_project/bmi_calculator/age_widget.dart';
import 'package:calorie_rush_project/bmi_calculator/gender_widget.dart';
import 'package:calorie_rush_project/bmi_calculator/height_widget.dart';
import 'package:calorie_rush_project/bmi_calculator/score_screen.dart';
import 'package:page_transition/page_transition.dart';
import 'package:swipeable_button_view/swipeable_button_view.dart';

class MyHomePage extends StatefulWidget {
  final List<Recipe> recipes;
  final List<Recipe> favoriteRecipes;
  final bool isLoading;
  final Function toggleFavorite;

  const MyHomePage(
      {super.key,
      required this.isLoading,
      required this.recipes,
      required this.favoriteRecipes,
      required this.toggleFavorite});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _gender = 0;
  int _height = 150;
  int _age = 30;
  int _weight = 50;
  bool _isFinished = false;
  double _bmiScore = 0;

  final List<Map<Recipe, dynamic>> _allRecipies = [];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  void _runFilter(String entered) {
    List<Map<Recipe, dynamic>> results = [];
    if (entered.isEmpty) {
      results = _allRecipies;
    } else {
      var x = _allRecipies;
      results = x
          .where((recipe) =>
              recipe["name"].toLowerCase().contains(entered.toLowerCase()))
          .toList();
    }
  }

  void calculateBmi() {
    _bmiScore = _weight / pow(_height / 100, 2);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60.0),
        child: AppBar(
          title: Row(
            children: const [
              Icon(
                Icons.restaurant_menu,
                color: Colors.white,
                size: 25,
              ),
              SizedBox(
                width: 10.0,
                height: 20.5,
              ),
              Text(
                'CalorieRush',
                style: TextStyle(color: Colors.white, fontSize: 25),
              )
            ],
          ),
        ),
      ),
      body: widget.isLoading
          ? const Center(child: CircularProgressIndicator())
          : TabBarView(
              controller: _tabController,
              children: [
                SingleChildScrollView(
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    child: Card(
                      elevation: 12,
                      shape: const RoundedRectangleBorder(),
                      child: Column(
                        children: [
                          //Lets create widget for gender selection
                          GenderWidget(
                            onChange: (genderVal) {
                              _gender = genderVal;
                            },
                          ),
                          HeightWidget(
                            onChange: (heightVal) {
                              _height = heightVal;
                            },
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              AgeWeightWidget(
                                  onChange: (ageVal) {
                                    _age = ageVal;
                                  },
                                  title: "Age",
                                  initValue: 30,
                                  min: 0,
                                  max: 100),
                              AgeWeightWidget(
                                  onChange: (weightVal) {
                                    _weight = weightVal;
                                  },
                                  title: "Weight(Kg)",
                                  initValue: 50,
                                  min: 0,
                                  max: 200)
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 20, horizontal: 60),
                            child: SwipeableButtonView(
                                isFinished: _isFinished,
                                onFinish: () async {
                                  await Navigator.push(
                                      context,
                                      PageTransition(
                                          child: ScoreScreen(
                                            bmiScore: _bmiScore,
                                            age: _age,
                                          ),
                                          type: PageTransitionType.fade));

                                  setState(() {
                                    _isFinished = false;
                                  });
                                },
                                onWaitingProcess: () {
                                  //Calculate BMI here
                                  calculateBmi();

                                  Future.delayed(Duration(seconds: 1), () {
                                    setState(() {
                                      _isFinished = true;
                                    });
                                  });
                                },
                                activeColor: Colors.lightGreen,
                                buttonWidget: const Icon(
                                  Icons.arrow_forward_ios_rounded,
                                  color: Colors.black,
                                ),
                                buttonText: "CALCULATE"),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      TextField(
                        onChanged: (value) => _runFilter(value),
                        decoration: const InputDecoration(
                          labelText: 'Search',
                          suffixIcon: Icon(Icons.search),
                        ),
                      ),
                      Expanded(
                        child: GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 15.0,
                            crossAxisSpacing: 15.0,
                            childAspectRatio: 0.8,
                          ),
                          itemCount: widget.recipes.length,
                          itemBuilder: (context, index) {
                            Recipe recipe = widget.recipes[index];
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        RecipeScreen(recipe: recipe),
                                  ),
                                );
                              },
                              child: Container(
                                height: 500,
                                decoration: const BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.white10,
                                      blurRadius: 15.0,
                                    ),
                                  ],
                                ),
                                child: Card(
                                  semanticContainer: true,
                                  shadowColor: Colors.grey,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                        child: Image.network(
                                          recipe.image,
                                          width: 150,
                                          height: 95,
                                          fit: BoxFit.fitWidth,
                                        ),
                                      ),
                                      const SizedBox(height: 8.0),
                                      Text(
                                        recipe.name,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                            color: Colors.black54),
                                        textAlign: TextAlign.center,
                                      ),
                                      IconButton(
                                        iconSize: 30,
                                        icon: Icon(
                                          recipe.isFavorite
                                              ? Icons.favorite_rounded
                                              : Icons.favorite_border_rounded,
                                          color: recipe.isFavorite
                                              ? Colors.pinkAccent
                                              : Colors.black54,
                                        ),
                                        onPressed: () =>
                                            widget.toggleFavorite(recipe),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      )
                    ],
                  ),
                ),
                ListView.builder(
                  itemCount: widget.favoriteRecipes.length,
                  itemBuilder: (context, index) {
                    Recipe recipe = widget.favoriteRecipes[index];
                    return ListTile(
                      title: Text(recipe.name),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => RecipeScreen(recipe: recipe),
                          ),
                        );
                      },
                      trailing: IconButton(
                        icon: const Icon(Icons.favorite,
                            color: Colors.pinkAccent),
                        onPressed: () => widget.toggleFavorite(recipe),
                      ),
                    );
                  },
                ),
              ],
            ),
      bottomNavigationBar: Material(
        color: Colors.lightGreen[200],
        child: TabBar(
          controller: _tabController,
          indicator: BoxDecoration(
            color: Colors.lightGreen[300],
          ),
          tabs: const [
            Tab(
              icon: Icon(
                Icons.calculate,
                color: Colors.white,
              ),
            ),
            Tab(
                icon: Icon(
              Icons.fastfood,
              color: Colors.white,
            )),
            Tab(
                icon: Icon(
              Icons.favorite,
              color: Colors.white,
            )),
          ],
        ),
      ),
    );
  }
}
