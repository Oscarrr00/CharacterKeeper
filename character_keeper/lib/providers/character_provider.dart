import 'package:character_keeper/http_handler.dart';
import 'package:flutter/material.dart';

class Character_Provide with ChangeNotifier {
  var httpHandler = new HttpHandler();
  List spells = [];
  List notes = [];
  List inventory = [];
  Future<Map<String, dynamic>> findSpell(String nameSpell) async {
    try {
      var name = nameSpell.toLowerCase();
      name = name.replaceAll(RegExp(' '), '-');
      var spell = await httpHandler.findSpell(name);
      return spell;
    } catch (e) {
      return {};
    }
  }

  void addSpell(String name, String level) {
    Map<String, dynamic> spell = {"name": name, "level": level};
    spells.add(spell);
  }

  void deleteSpell(int index) {
    spells.removeAt(index);
  }

  void addNote(String title, String description) {
    Map<String, dynamic> note = {"title": title, "description": description};
    notes.add(note);
  }

  void deleteNote(int index) {
    notes.removeAt(index);
  }

  void addItem(String title, String description, int quantity) {
    Map<String, dynamic> item = {
      "name": title,
      "description": description,
      "quantity": quantity
    };
    inventory.add(item);
  }

  void deleteItem(int index) {
    inventory.removeAt(index);
  }
}
