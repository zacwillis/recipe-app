import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zackie_snacks/models/recipe.dart';
import 'package:zackie_snacks/providers/recipes.dart';

class RecipeDetailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final recipeId = ModalRoute.of(context).settings.arguments as String;
    final recipe = Provider.of<Recipes>(context, listen: false)
        .findById(recipeId.toString());
    return Scaffold(
      appBar: AppBar(
        title: Text(recipe.name),
      ),
    );
  }
}