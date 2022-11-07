import 'package:character_keeper/http_handler.dart';
import 'package:character_keeper/objects/ability.dart';
import 'package:character_keeper/objects/character.dart';
import 'package:character_keeper/objects/inventory_entry.dart';
import 'package:character_keeper/objects/note.dart';
import 'package:character_keeper/objects/spell.dart';
import 'package:flutter/material.dart';

class Character_Provide with ChangeNotifier {

  List characterList = [Character.fromJson(myCharacter)];

  Character currentCharacter = Character.fromJson(myCharacter);
  

  var httpHandler = new HttpHandler();

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

  void setCurrentCharacter(int index) {
    currentCharacter = characterList[index];
    notifyListeners();
  }

  void addSpell(String name, int level) {
    Spell spell = Spell(name: name, level: level);
    currentCharacter.spells.add(spell);
    currentCharacter.spells.sort(((a, b) => a.level.compareTo(b.level)));
    notifyListeners();
  }

  void deleteSpell(int index) {
    currentCharacter.spells.removeAt(index);
    notifyListeners();
  }

  void addNote(String title, String description) {
    Note note = Note(title: title, description: description);
    currentCharacter.notes.add(note);
    notifyListeners();
  }

  void deleteNote(int index) {
    currentCharacter.notes.removeAt(index);
    notifyListeners();
  }

  void addItem(String name, String description, int quantity) {
    InventoryEntry item = InventoryEntry(amount: quantity, name: name, description: description);
    currentCharacter.inventory.add(item);
    notifyListeners();
  }

  void deleteItem(int index) {
    currentCharacter.inventory.removeAt(index);
    notifyListeners();
  }

  void addAbility(String name, String description) {
    Ability ability = Ability(name: name, description: description);
    currentCharacter.abilities.add(ability);
    notifyListeners();
  }

  void deleteAbility(int index) {
    currentCharacter.abilities.removeAt(index);
    notifyListeners();
  }

  void addCharacter(String name, String character_class, int level, String race) {
    Character character = Character(
      name: name,
      character_class: character_class,
      level: level,
      race: race,
      armor_class: 10,
      initiative: 2,
      speed: 30,
      maximum_hitpoints: 10,
      current_hitpoints: 10,
      temporary_hitpoints: 0,
      hit_dice: "d8",
      hit_dice_amount: 5,
      strength: 10,
      dexterity: 10,
      constitution: 10,
      intelligence: 10,
      wisdom: 10,
      charisma: 10,
      saving_throw_proficiencies: [0, 0, 0, 0, 0, 0],
      proficiency_bonus: 2,
      proficiencies: [
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,        
      ],
      abilities: [],
      inventory: [],
      spells: [],
      notes: [],
      spell_slots: [
        [0, 0],
        [0, 0],
        [0, 0],
        [0, 0],
        [0, 0],
        [0, 0],
        [0, 0],
        [0, 0],
        [0, 0],
      ]
    );

    characterList.add(character);
    notifyListeners();
  }

  
}


