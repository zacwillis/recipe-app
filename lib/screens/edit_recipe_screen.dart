import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zackie_snacks/models/recipe.dart';
import 'package:zackie_snacks/providers/recipes.dart';
import 'package:zackie_snacks/screens/routes.dart';

class EditRecipeScreen extends StatefulWidget {
  @override
  _EditRecipeScreenState createState() => _EditRecipeScreenState();
}

class _EditRecipeScreenState extends State<EditRecipeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  final _imageUrlController = TextEditingController();
  var _type = "";
  var _list = [];
  var _editedRecipe = Recipe(
      id: null,
      name: '',
      ingredients: [],
      instructions: [],
      imageUrl: '',
      isFavorite: null);
  var _isInit = true;

  @override
  void dispose() {
    _imageUrlController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      _editedRecipe = ModalRoute.of(context).settings.arguments as Recipe;
      _imageUrlController.text = _editedRecipe.imageUrl;
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      endDrawer: _openDrawer(_type, _list),
      appBar: AppBar(
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.delete_forever,
              color: Colors.white,
            ),
            onPressed: () {
              showDialog<void>(
                context: context,
                barrierDismissible: false,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Delete Recipe?'),
                    content: SingleChildScrollView(
                      child: ListBody(
                        children: <Widget>[
                          Text('Are you sure you want to delete this recipe?'),
                        ],
                      ),
                    ),
                    actions: <Widget>[
                      TextButton(
                        child: Text('Delete'),
                        onPressed: () {
                          Provider.of<Recipes>(context, listen: false)
                              .deleteRecipe(_editedRecipe.id);
                          Navigator.of(context).pushNamed(Routes.allRecipes);
                        },
                      ),
                      TextButton(
                        child: Text('Cancel'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
        title: Text("Edit Recipe"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  initialValue: _editedRecipe.name,
                  onSaved: (value) {
                    _editedRecipe = Recipe(
                      id: _editedRecipe.id,
                      name: value,
                      ingredients: _editedRecipe.ingredients,
                      instructions: _editedRecipe.instructions,
                      isFavorite: _editedRecipe.isFavorite,
                    );
                  },
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Please add a recipe name.";
                    } else {
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                    labelText: "Recipe Name",
                  ),
                  textInputAction: TextInputAction.next,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 30.0),
                  child: SizedBox(
                    width: double.infinity,
                    child: OutlineButton(
                      textColor: Theme.of(context).primaryColor,
                      borderSide: BorderSide(
                          width: 1.0, color: Theme.of(context).primaryColor),
                      onPressed: () {
                        setState(() {
                          _list = _editedRecipe.ingredients;
                          _type = "Ingredients";
                          _scaffoldKey.currentState.openEndDrawer();
                        });
                      },
                      child: Text(
                        "Edit Ingredients",
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: SizedBox(
                    width: double.infinity,
                    child: OutlineButton(
                      textColor: Theme.of(context).primaryColor,
                      borderSide: BorderSide(
                          width: 1.0, color: Theme.of(context).primaryColor),
                      onPressed: () {
                        setState(() {
                          _list = _editedRecipe.instructions;
                          _type = "Instructions";
                          _scaffoldKey.currentState.openEndDrawer();
                        });
                      },
                      child: Text(
                        "Edit Instructions",
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 40.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        width: 100,
                        height: 100,
                        margin: EdgeInsets.only(top: 8, right: 10),
                        child: _imageUrlController.text.isEmpty
                            ? Text("Enter a url")
                            : FittedBox(
                                child: Image.network(_imageUrlController.text),
                                fit: BoxFit.cover,
                              ),
                      ),
                      Expanded(
                        child: TextFormField(
                          onSaved: (value) {
                            _editedRecipe = Recipe(
                              id: _editedRecipe.id,
                              name: _editedRecipe.name,
                              ingredients: _editedRecipe.ingredients,
                              instructions: _editedRecipe.instructions,
                              isFavorite: _editedRecipe.isFavorite,
                              imageUrl: value,
                            );
                          },
                          validator: (value) {
                            if (!value.startsWith('http') &&
                                !value.startsWith('https')) {
                              return "Please enter a valid url.";
                            }
                            // if (!value.endsWith('.png') &&
                            //     !value.endsWith(".jpg") &&
                            //     !value.endsWith(".jpeg") &&
                            //     !value.endsWith(".JPG") &&
                            //     !value.endsWith(".JPEG") &&
                            //     !value.endsWith(".PNG")) {
                            //   return "Please enter a valid image url.";
                            // }
                            return null;
                          },
                          decoration: InputDecoration(labelText: 'Image URL'),
                          keyboardType: TextInputType.url,
                          textInputAction: TextInputAction.done,
                          controller: _imageUrlController,
                          onEditingComplete: () {
                            FocusScope.of(context).requestFocus(FocusNode());
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 50),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      RaisedButton(
                        onPressed: () {
                          final isValid = _formKey.currentState.validate();
                          if (!isValid) {
                            return;
                          }
                          _formKey.currentState.save();
                          Provider.of<Recipes>(context, listen: false)
                              .updateRecipe(_editedRecipe);
                          Navigator.of(context).pushNamed(Routes.allRecipes);
                        },
                        color: Colors.green,
                        child: Text(
                          "Submit",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _openDrawer(String type, List list) {
    return Drawer(
      child: Column(
        children: <Widget>[
          Container(
            height: 80,
            child: DrawerHeader(
                child: Center(
                    child: Text(type,
                        style: TextStyle(color: Colors.white, fontSize: 20))),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                )),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                  children: list.map((item) {
                return Container(
                  margin: EdgeInsets.only(left: 50),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      type == "Ingredients"
                          ? Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: Text(
                                "• ${item.name} - ${item.quantity}",
                                style: TextStyle(fontSize: 20),
                              ),
                            )
                          : Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: Text(
                                "• ${item.step} - ${item.description}",
                                style: TextStyle(fontSize: 20),
                              ),
                            )
                    ],
                  ),
                );
              }).toList()),
            ),
          )
        ],
      ),
    );
  }
}
