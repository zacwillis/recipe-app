import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zackie_snacks/providers/recipes.dart';
import 'package:zackie_snacks/widgets/recipe_thumbnail.dart';

class AllRecipesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Recipes"),
      ),
      body: RecipeGrid(),
    );
  }
}

class RecipeGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final recipeData = Provider.of<Recipes>(context);
    final recipes = recipeData.recipes;
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
