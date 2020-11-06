class Ingredient {
  String id;
  String recipeId;
  String name;
  String quantity;

  Ingredient({this.id, this.recipeId, this.name, this.quantity});

  // Ingredient.fromJson(Map<String, dynamic> jsonData) {
  //   id = jsonData["id"];
  //   recipeId = jsonData["recipeId"];
  //   name = jsonData["name"];
  //   quantity = jsonData["quantity"];
  // }
}
