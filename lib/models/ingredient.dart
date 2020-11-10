class Ingredient {
  String id;
  String recipeId;
  String name;
  String quantity;

  Ingredient({this.id, this.recipeId, this.name, this.quantity});

  Map<String, dynamic> toJson() {
    return {
      "name": this.name,
      "quantity": this.quantity,
      "recipeId": this.recipeId
    };
  }
}
