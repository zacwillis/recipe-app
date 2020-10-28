import 'package:flutter/material.dart';
import 'package:zackie_snacks/models/ingredient.dart';
import 'package:zackie_snacks/models/instruction.dart';
import 'package:zackie_snacks/models/recipe.dart';
import 'package:zackie_snacks/widgets/recipe_thumbnail.dart';

class AllRecipesScreen extends StatelessWidget {
  final List<Recipe> loadedRecipes = [
    Recipe(
      id: 1,
      name: "Test Recipe 1",
      ingredients: [
        Ingredient(id: 1, recipeId: 1, name: "Ground Beef", quantity: "1 lb"),
        Ingredient(id: 2, recipeId: 1, name: "Cheese", quantity: "4 slices")
      ],
      instructions: [
        Instruction(
            id: 1,
            recipeId: 1,
            step: 1,
            description: "Form ground beef into patties."),
        Instruction(
            id: 2,
            recipeId: 1,
            step: 2,
            description: "Cook patties. Add cheese.")
      ],
      imageUrl:
          "https://assets.epicurious.com/photos/57c5c6d9cf9e9ad43de2d96e/master/pass/the-ultimate-hamburger.jpg",
    ),
    Recipe(
      id: 2,
      name: "Test Recipe 2",
      ingredients: [
        Ingredient(id: 3, recipeId: 2, name: "Ribeye Steak", quantity: "1"),
        Ingredient(
            id: 4, recipeId: 2, name: "Compound Butter", quantity: "3 tbsp")
      ],
      instructions: [
        Instruction(id: 3, recipeId: 2, step: 1, description: "Grill Ribeye"),
        Instruction(
            id: 4, recipeId: 2, step: 2, description: "Add Compound butter"),
      ],
      imageUrl:
          "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcTDHp87tYPlV7lDqQ43fxTntzyIsXPRiyZdaQ&usqp=CAU",
    ),
    Recipe(
      id: 3,
      name: "Test Recipe 3",
      ingredients: [
        Ingredient(id: 5, recipeId: 3, name: "Chicken", quantity: "1"),
        Ingredient(id: 6, recipeId: 3, name: "Veggies", quantity: "2 cups")
      ],
      instructions: [
        Instruction(id: 5, recipeId: 3, step: 1, description: "Grill Chicken"),
        Instruction(id: 6, recipeId: 3, step: 2, description: "Cook Veggies"),
      ],
      imageUrl: "https://via.placeholder.com/350x150",
    ),
    Recipe(
      id: 3,
      name: "Test Recipe 3",
      ingredients: [
        Ingredient(id: 7, recipeId: 4, name: "Chicken", quantity: "1"),
        Ingredient(id: 8, recipeId: 4, name: "Veggies", quantity: "2 cups")
      ],
      instructions: [
        Instruction(id: 7, recipeId: 4, step: 1, description: "Grill Chicken"),
        Instruction(id: 8, recipeId: 4, step: 2, description: "Cook Veggies"),
      ],
      imageUrl: "https://via.placeholder.com/350x150",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Recipes"),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(10),
        itemCount: loadedRecipes.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemBuilder: (context, index) => RecipeThumbnail(
            loadedRecipes[index].id,
            loadedRecipes[index].name,
            loadedRecipes[index].imageUrl),
      ),
    );
  }
}
