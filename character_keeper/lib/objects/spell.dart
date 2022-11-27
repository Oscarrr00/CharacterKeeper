class Spell {
  int level;
  String name;

  Spell({
    required this.level,
    required this.name,
  });

  Map<String, dynamic> toJson() {
    return {"name": name, "level": level};
  }
}
