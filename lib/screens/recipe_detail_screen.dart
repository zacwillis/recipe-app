import 'package:flutter/material.dart';
import 'package:zackie_snacks/models/recipe.dart';
import 'package:zackie_snacks/screens/routes.dart';

class RecipeDetailScreen extends StatefulWidget {
  @override
  _RecipeDetailScreenState createState() => _RecipeDetailScreenState();
}

Widget buildHeading(String heading) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 10),
    child: Padding(
      padding: const EdgeInsets.only(left: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            heading,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
        ],
      ),
    ),
  );
}

Widget buildList(Recipe recipe, String listType) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: listType == "ingredients"
        ? recipe.ingredients.map((ing) {
            return Container(
              margin: EdgeInsets.only(left: 50),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Text(
                      "•  ${ing.name} - ${ing.quantity}",
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ],
              ),
            );
          }).toList()
        : recipe.instructions.map((inst) {
            return Container(
              margin: EdgeInsets.only(left: 50),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Text(
                      "${inst.step}.  ${inst.description}",
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
  );
}

class _RecipeDetailScreenState extends State<RecipeDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final recipe = ModalRoute.of(context).settings.arguments as Recipe;
    // final recipe = Provider.of<Recipe>(context, listen: false)
    //     .findById(recipeId.toString());
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, Routes.editRecipe, arguments: recipe);
        },
        child: Icon(Icons.edit_outlined),
        backgroundColor: Colors.orangeAccent[700],
      ),
      appBar: AppBar(
        title: Text(recipe.name),
        centerTitle: true,
        actions: [
          Builder(builder: (BuildContext context) {
            return IconButton(
                padding: EdgeInsets.only(right: 15),
                icon: Icon(
                  recipe.isFavorite == true
                      ? Icons.favorite
                      : Icons.favorite_border,
                  size: 30,
                ),
                onPressed: () {
                  Scaffold.of(context).hideCurrentSnackBar();
                  Scaffold.of(context).showSnackBar(
                    SnackBar(
                      content: Text(recipe.isFavorite
                          ? "Recipe removed from favorites"
                          : "Recipe added to favorites"),
                      duration: Duration(seconds: 1),
                    ),
                  );
                  setState(() {
                    recipe.isFavorite = !recipe.isFavorite;
                  });
                });
          })
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 10),
              height: 225,
              width: double.infinity,
              child: Image.network(
                recipe.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            buildHeading("Ingredients"),
            buildList(recipe, "ingredients"),
            SizedBox(height: 25),
            buildHeading("Instructions"),
            buildList(recipe, "instructions"),
          ],
        ),
      ),
    );
  }
}
