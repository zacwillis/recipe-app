import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zackie_snacks/providers/recipes.dart';
import 'package:zackie_snacks/widgets/recipe_thumbnail.dart';

import 'routes.dart';

enum FilterOptions {
  Favorites,
  All,
}

class AllRecipesScreen extends StatefulWidget {
  @override
  _AllRecipesScreenState createState() => _AllRecipesScreenState();
}

class _AllRecipesScreenState extends State<AllRecipesScreen> {
  var _showOnlyFavorites = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, Routes.addNewRecipe);
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.orangeAccent[700],
      ),
      appBar: AppBar(
        title: Text("Recipes"),
        actions: <Widget>[
          PopupMenuButton(
            onSelected: (value) {
              setState(() {
                if (value == FilterOptions.Favorites) {
                  _showOnlyFavorites = true;
                } else {
                  _showOnlyFavorites = false;
                }
              });
            },
            itemBuilder: (_) => [
              PopupMenuItem(
                value: FilterOptions.All,
                child: Text("All Recipes"),
              ),
              PopupMenuItem(
                value: FilterOptions.Favorites,
                child: Text("Only Favorites"),
              ),
            ],
            icon: Icon(
              Icons.filter_alt_outlined,
              size: 32,
            ),
          ),
        ],
      ),
      body: RecipeGrid(_showOnlyFavorites),
    );
  }
}

class RecipeGrid extends StatelessWidget {
  final bool showOnlyFavs;

  RecipeGrid(this.showOnlyFavs);
  @override
  Widget build(BuildContext context) {
    final recipeData = Provider.of<Recipes>(context);
    final recipes =
        showOnlyFavs ? recipeData.favoriteRecipes : recipeData.recipes;
    return GridView.builder(
      itemCount: recipes.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1 / 1,
      ),
      itemBuilder: (context, index) => RecipeThumbnail(recipes[index]),
    );
  }
}
