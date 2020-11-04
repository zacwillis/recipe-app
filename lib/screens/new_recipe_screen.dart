import 'package:flutter/material.dart';

class NewRecipeScreen extends StatefulWidget {
  @override
  _NewRecipeScreenState createState() => _NewRecipeScreenState();
}

class _NewRecipeScreenState extends State<NewRecipeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final _imageUrlController = TextEditingController();
  List<Widget> _ingredients = List<Widget>();
  List<Widget> _instructions = List<Widget>();
  List<Widget> _list = List<Widget>();
  var _type = "";

  @override
  void dispose() {
    _imageUrlController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      endDrawer: _openDrawer(_type, _list),
      appBar: AppBar(
        actions: <Widget>[
          new Container(),
        ],
        title: Text("New Recipe"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Form(
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
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
                          _list = _ingredients;
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
                          width: 1.0, color: Theme.of(context).primaryColor),
                      onPressed: () {
                        setState(() {
                          _list = _instructions;
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
                                child: Image.network(_imageUrlController.text),
                                fit: BoxFit.cover,
                              ),
                      ),
                      Expanded(
                        child: TextFormField(
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
              ],
            ),
          ),
        ),
      ),
    );
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
                              ? IngInputWidget()
                              : InstInputWidget());
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
          ],
        ),
      ),
    );
  }
}

class IngInputWidget extends StatelessWidget {
  // String fieldName;
  // InputWidget({this.fieldName = ''});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Form(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              width: 160,
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: "Ingredient",
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Container(
              width: 80,
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: "QTY",
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

class InstInputWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Form(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              width: 50,
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: "Step",
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Container(
              width: 170,
              child: TextFormField(
                maxLines: 4,
                minLines: 1,
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