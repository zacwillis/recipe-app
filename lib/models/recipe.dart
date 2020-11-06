import 'package:flutter/material.dart';
import 'package:zackie_snacks/models/ingredient.dart';
import 'package:zackie_snacks/models/instruction.dart';

class Recipe {
  String id;
  String name;
  List<Ingredient> ingredients;
  List<Instruction> instructions;
  String imageUrl;
  bool isFavorite;

  Recipe(
      {this.id,
      this.name,
      this.ingredients,
      this.instructions,
      this.imageUrl,
      this.isFavorite = false});

  // void toggleFavoriteStatus() {
  //   isFavorite = !isFavorite;
  //   notifyListeners();
  // }
}
