import 'package:flutter/material.dart';

class EditRecipeScreen extends StatefulWidget {
  @override
  _EditRecipeScreenState createState() => _EditRecipeScreenState();
}

class _EditRecipeScreenState extends State<EditRecipeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  var _type = "";
  final _imageUrlController = TextEditingController();

  @override
  void dispose() {
    _imageUrlController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      endDrawer: _openDrawer(_type),
      appBar: AppBar(
        actions: <Widget>[
          new Container(),
        ],
        title: Text("Edit Recipe"),
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
                          //   _list = _ingredients;
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
                          // _list = _instructions;
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

  Widget _openDrawer(String type) {
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
              child: null,
            ),
          )
        ],
      ),
    );
  }
}
