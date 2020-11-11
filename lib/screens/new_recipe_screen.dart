import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zackie_snacks/models/ingredient.dart';
import 'package:zackie_snacks/models/instruction.dart';
import 'package:zackie_snacks/models/recipe.dart';
import 'package:zackie_snacks/providers/recipes.dart';

class NewRecipeScreen extends StatefulWidget {
  @override
  _NewRecipeScreenState createState() => _NewRecipeScreenState();
}

class _NewRecipeScreenState extends State<NewRecipeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  final _imageUrlController = TextEditingController();
  List<Widget> _ingWidget = List<Widget>();
  List<Widget> _instWidget = List<Widget>();
  List<Widget> _widgetList = List<Widget>();
  var _type = "";
  var _busy = false;
  var _newRecipe = Recipe(
      id: null,
      name: '',
      ingredients: [],
      instructions: [],
      imageUrl: '',
      isFavorite: null);

  @override
  void dispose() {
    _imageUrlController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      endDrawer: _openDrawer(_type, _widgetList),
      appBar: AppBar(
        actions: <Widget>[
          new Container(),
        ],
        title: Text("New Recipe"),
      ),
      body: _busy
          ? Center(
              child: CircularProgressIndicator(
                backgroundColor: Theme.of(context).primaryColor,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(10.0),
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      TextFormField(
                        onSaved: (value) {
                          _newRecipe = Recipe(
                            id: null,
                            name: value,
                            ingredients: _newRecipe.ingredients,
                            instructions: _newRecipe.instructions,
                            isFavorite: _newRecipe.isFavorite,
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
                        textInputAction: TextInputAction.done,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 30.0),
                        child: SizedBox(
                          width: double.infinity,
                          child: OutlineButton(
                            textColor: Theme.of(context).primaryColor,
                            borderSide: BorderSide(
                                width: 1.0,
                                color: Theme.of(context).primaryColor),
                            onPressed: () {
                              setState(() {
                                _widgetList = _ingWidget;
                                _type = "Ingredients";
                                _scaffoldKey.currentState.openEndDrawer();
                              });
                            },
                            child: Text(
                              "Add Ingredients",
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
                                width: 1.0,
                                color: Theme.of(context).primaryColor),
                            onPressed: () {
                              setState(() {
                                _widgetList = _instWidget;
                                _type = "Instructions";
                                _scaffoldKey.currentState.openEndDrawer();
                              });
                            },
                            child: Text(
                              "Add Instructions",
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
                                      child: Image.network(
                                          _imageUrlController.text),
                                      fit: BoxFit.cover,
                                    ),
                            ),
                            Expanded(
                              child: TextFormField(
                                onSaved: (value) {
                                  _newRecipe = Recipe(
                                    id: null,
                                    name: _newRecipe.name,
                                    ingredients: _newRecipe.ingredients,
                                    instructions: _newRecipe.instructions,
                                    imageUrl: value,
                                  );
                                },
                                validator: (value) {
                                  if (!value.startsWith('http') &&
                                      !value.startsWith('https')) {
                                    return "Please enter a valid url.";
                                  }
                                  if (!value.endsWith('.png') &&
                                      !value.endsWith(".jpg") &&
                                      !value.endsWith(".jpeg") &&
                                      !value.endsWith(".JPG") &&
                                      !value.endsWith(".JPEG") &&
                                      !value.endsWith(".PNG")) {
                                    return "Please enter a valid image url.";
                                  }
                                  return null;
                                },
                                decoration:
                                    InputDecoration(labelText: 'Image URL'),
                                keyboardType: TextInputType.url,
                                textInputAction: TextInputAction.done,
                                controller: _imageUrlController,
                                onEditingComplete: () {
                                  FocusScope.of(context)
                                      .requestFocus(FocusNode());
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
                              onPressed: () async {
                                final isValid =
                                    _formKey.currentState.validate();
                                if (!isValid) {
                                  return;
                                }
                                _formKey.currentState.save();
                                setState(() {
                                  _busy = true;
                                });
                                try {
                                  await Provider.of<Recipes>(context,
                                          listen: false)
                                      .addRecipe(_newRecipe);
                                } catch (error) {
                                  showDialog<Null>(
                                    context: context,
                                    builder: (ctx) => AlertDialog(
                                      title: Text("An error occurred!"),
                                      content: Text(
                                          "Something went wrong creating the recipe."),
                                      actions: [
                                        FlatButton(
                                          child: Text("OK"),
                                          onPressed: () {
                                            Navigator.of(ctx).pop();
                                          },
                                        )
                                      ],
                                    ),
                                  );
                                } finally {
                                  setState(() {
                                    _busy = false;
                                  });
                                  Navigator.of(context).pop();
                                }
                              },
                              color: Colors.green,
                              child: Text(
                                "Submit",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
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

  void addIng(Map ingredient) {
    Ingredient _newIngredient =
        Ingredient(name: ingredient['name'], quantity: ingredient["qty"]);
    _newRecipe.ingredients.add(_newIngredient);
  }

  void addInst(Map instruction) {
    Instruction _newInstruction = Instruction(
        step: int.parse(instruction['step']),
        description: instruction["description"]);
    _newRecipe.instructions.add(_newInstruction);
  }

  Widget _openDrawer(String type, List<Widget> _listType) {
    return Drawer(
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: 90,
              child: DrawerHeader(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      type,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          _listType.add(type == "Ingredients"
                              ? IngInputWidget(addIng)
                              : InstInputWidget(addInst));
                        });
                      },
                      icon: Icon(Icons.add),
                      color: Colors.white,
                      iconSize: 32,
                    ),
                  ],
                ),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
            Column(
              children: List.generate(_listType.length, (i) {
                return _listType[i];
              }),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                children: [
                  RaisedButton(
                    color: Colors.green,
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      "Done",
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class IngInputWidget extends StatelessWidget {
  final Function ingHandler;
  IngInputWidget(this.ingHandler);

  final _ingController = TextEditingController();
  final _qtyController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final node = FocusScope.of(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            width: 160,
            child: TextFormField(
              controller: _ingController,
              decoration: InputDecoration(
                labelText: "Ingredient",
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Container(
            width: 80,
            child: TextFormField(
              controller: _qtyController,
              textInputAction: TextInputAction.done,
              onEditingComplete: () {
                if (_ingController.text.isNotEmpty) {
                  ingHandler({
                    'name': _ingController.text,
                    'qty': _qtyController.text
                  });
                  node.unfocus();
                  _ingController.text = null;
                  _qtyController.text = null;
                }
              },
              decoration: InputDecoration(
                labelText: "QTY",
                border: OutlineInputBorder(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class InstInputWidget extends StatelessWidget {
  final Function instHandler;
  InstInputWidget(this.instHandler);

  final _stepController = TextEditingController();
  final _descController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final node = FocusScope.of(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Form(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              width: 50,
              child: TextFormField(
                controller: _stepController,
                decoration: InputDecoration(
                  labelText: "Step",
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Container(
              width: 170,
              child: TextFormField(
                controller: _descController,
                textInputAction: TextInputAction.done,
                maxLines: 4,
                minLines: 1,
                onEditingComplete: () {
                  if (_descController.text.isNotEmpty) {
                    instHandler({
                      'step': _stepController.text,
                      'description': _descController.text
                    });
                    node.unfocus();
                    _descController.text = null;
                    _stepController.text = null;
                  }
                },
                decoration: InputDecoration(
                  labelText: "Instruction",
                  border: OutlineInputBorder(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
