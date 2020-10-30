import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zackie_snacks/models/recipe.dart';
import 'package:zackie_snacks/screens/routes.dart';

class RecipeThumbnail extends StatelessWidget {
  final Recipe recipe;

  RecipeThumbnail(this.recipe);
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 10,
      margin: EdgeInsets.fromLTRB(5, 20, 5, 0),
      child: Column(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
            child: GestureDetector(
              onTap: () {
                Navigator.of(context)
                    .pushNamed(Routes.recipeDetail, arguments: recipe);
              },
              child: Image.network(
                recipe.imageUrl,
                height: 127,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      recipe.name,
                      style: TextStyle(fontSize: 20),
                    ),
                    // IconButton(
                    //   icon: Icon(
                    //     recipe.isFavorite == false
                    //         ? Icons.favorite_border
                    //         : Icons.favorite,
                    //     size: 24,
                    //   ),
                    //   onPressed: () {
                    //     recipe.toggleFavoriteStatus();
                    //   },
                    // ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
