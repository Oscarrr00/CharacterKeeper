class InventoryEntry {
  int amount;
  String name;
  String description;

  InventoryEntry(
      {required this.amount, required this.name, required this.description});

  Map<String, dynamic> toJson() {
    return {"amount": amount, "name": name, "description": description};
  }
}
