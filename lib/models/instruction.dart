class Instruction {
  String id;
  String recipeId;
  int step;
  String description;

  Instruction({this.id, this.recipeId, this.step, this.description});

  Map<String, dynamic> toJson() {
    return {"step": this.step, "description": this.description};
  }
}
