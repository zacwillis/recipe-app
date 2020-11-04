import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:zackie_snacks/screens/all_recipes_screen.dart';
import 'package:zackie_snacks/screens/edit_recipe_screen.dart';
import 'package:zackie_snacks/screens/new_recipe_screen.dart';
import 'package:zackie_snacks/screens/recipe_detail_screen.dart';
import './providers/recipes.dart';
import 'screens/routes.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return ChangeNotifierProvider(
      create: (context) => Recipes(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Zackie Snacks',
        theme: ThemeData(
          fontFamily: 'Lato',
          primaryColor: Colors.orangeAccent[700],
          visualDensity: VisualDensity.adaptivePlatformDensity,
          appBarTheme: AppBarTheme(
            textTheme: TextTheme(
                headline6: TextStyle(color: Colors.white, fontSize: 26)),
          ),
        ),
        home: AllRecipesScreen(),
        routes: {
          Routes.recipeDetail: (context) => RecipeDetailScreen(),
          Routes.addNewRecipe: (context) => NewRecipeScreen(),
          Routes.editRecipe: (context) => EditRecipeScreen(),
        },
      ),
    );
  }
}
