class Ability {
  String name;
  String description;

  Ability({required this.name, required this.description});

  Map<String, dynamic> toJson() {
    return {"name": name, "description": description};
  }
}
