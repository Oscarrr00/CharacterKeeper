class Note {
  String title;
  String description;

  Note({required this.title, required this.description});
  Map<String, dynamic> toJson() {
    return {"title": title, "description": description};
  }
}
