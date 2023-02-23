import 'package:flutter/material.dart';
import 'package:calorie_rush_project/model/recipe.dart';
import 'details.dart';

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

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
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
                Padding(
                  padding: const EdgeInsets.all(15.0),
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
                                  borderRadius: BorderRadius.circular(8.0),
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
