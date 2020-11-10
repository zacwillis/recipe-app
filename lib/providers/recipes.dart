import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
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
    const url = 'https://zackie-snacks-cf721.firebaseio.com/recipes.json';
    http
        .post(
      url,
      body: json.encode(
        {
          'name': recipe.name,
          'imageUrl': recipe.imageUrl,
          'ingredients': recipe.ingredients,
          'instructions': recipe.instructions
        },
      ),
    )
        .then((response) {
      final newRecipe = Recipe(
        id: json.decode(response.body)['name'],
        name: recipe.name,
        ingredients: recipe.ingredients,
        instructions: recipe.instructions,
        imageUrl: recipe.imageUrl,
        isFavorite: false,
      );
      _recipes.add(newRecipe);
      notifyListeners();
    });
  }

  // void addIngredient(String recipeId, List<Ingredient> ingredients) {
  //   for (Ingredient ing in ingredients) {
  //     ing.recipeId = recipeId;
  //   }
  //   var data = jsonEncode(ingredients);
  //   const url = 'https://zackie-snacks-cf721.firebaseio.com/ingredients.json';
  //   http
  //       .post(
  //     url,
  //     body: data,
  //   )
  //       .then((value) {
  //     print(json.decode(value.body));
  //   });
  // }

  // void addInstruction(String recipeId, List<Instruction> instructions) {
  //   for (Instruction inst in instructions) {
  //     inst.recipeId = recipeId;
  //   }
  //   const url = 'https://zackie-snacks-cf721.firebaseio.com/instructions.json';
  //   http
  //       .post(
  //         url,
  //         body: json.encode(
  //           {instructions},
  //         ),
  //       )
  //       .then((value) => null);
  // }

  void updateRecipe(Recipe recipe) {
    final recipeIndex = _recipes.indexWhere((rec) => rec.id == recipe.id);
    _recipes[recipeIndex] = recipe;
    notifyListeners();
  }

  void deleteRecipe(String id) {
    _recipes.removeWhere((rec) => rec.id == id);
    notifyListeners();
  }
}
