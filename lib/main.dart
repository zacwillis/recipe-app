import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:zackie_snacks/screens/all_recipes_screen.dart';

import 'screens/routes.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Zackie Snacks',
      theme: ThemeData(
        fontFamily: 'Lato',
        primarySwatch: Colors.lightBlue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: AllRecipesScreen(),
      // initialRoute: Routes.home,
      // routes: {
      //   Routes.recipeScreen: (context) => AllRecipesScreen(),
      // },
    );
  }
}
