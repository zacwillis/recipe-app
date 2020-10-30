import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zackie_snacks/models/recipe.dart';
import 'package:zackie_snacks/providers/recipes.dart';

class RecipeDetailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final recipe = ModalRoute.of(context).settings.arguments as Recipe;
    // final recipe = Provider.of<Recipe>(context, listen: false)
    //     .findById(recipeId.toString());
    return Scaffold(
      appBar: AppBar(
        title: Text(recipe.name),
        centerTitle: true,
        actions: [
          IconButton(
              padding: EdgeInsets.only(right: 15),
              icon: Icon(
                recipe.isFavorite == true
                    ? Icons.favorite
                    : Icons.favorite_border,
                size: 30,
              ),
              onPressed: () {})
        ],
      ),
    );
  }
}
