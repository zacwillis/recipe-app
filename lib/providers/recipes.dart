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

  void addRecipe() {
    // _recipes.add(value);
    notifyListeners();
  }
}
