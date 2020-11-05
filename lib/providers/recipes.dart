import 'dart:math';

import 'package:flutter/material.dart';
import 'package:zackie_snacks/Test/test_data.dart';
import 'package:zackie_snacks/models/recipe.dart';

class Recipes with ChangeNotifier {
  List<Recipe> _recipes = DUMMY_RECIPES;

  List<Recipe> get recipes {
    return [..._recipes];
  }

  List<Recipe> get favoriteRecipes {
    return _recipes.where((element) => element.isFavorite).toList();
  }

  Recipe findById(String id) {
    return _recipes.firstWhere((rp) => rp.id.toString() == id);
  }

  void addRecipe(Recipe recipe) {
    final newRecipe = Recipe(
      id: Random().nextInt(10),
      name: recipe.name,
      ingredients: recipe.ingredients,
      instructions: recipe.instructions,
      imageUrl: recipe.imageUrl,
      isFavorite: false,
    );
    _recipes.add(newRecipe);
    notifyListeners();
  }

  void updateRecipe(Recipe recipe) {
    final recipeIndex = _recipes.indexWhere((rec) => rec.id == recipe.id);
    _recipes[recipeIndex] = recipe;
    notifyListeners();
  }
}
