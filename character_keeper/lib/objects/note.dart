class Note {
  String title;
  String description;
  String image;

  Note({required this.title, required this.description, required this.image});
  Map<String, dynamic> toJson() {
    return {"title": title, "description": description, "image": image};
  }
}
