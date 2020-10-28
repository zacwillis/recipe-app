import 'ingredient.dart';
import 'instruction.dart';

class Recipe {
  final int id;
  final String name;
  final List<Ingredient> ingredients;
  final List<Instruction> instructions;
  final String imageUrl;
  bool isFavorite;

  Recipe(
      {this.id,
      this.name,
      this.ingredients,
      this.instructions,
      this.imageUrl,
      this.isFavorite = false});
}
