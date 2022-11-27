import 'package:character_keeper/http_handler.dart';
import 'package:character_keeper/objects/ability.dart';
import 'package:character_keeper/objects/character.dart';
import 'package:character_keeper/objects/inventory_entry.dart';
import 'package:character_keeper/objects/note.dart';
import 'package:character_keeper/objects/spell.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Character_Provide with ChangeNotifier {
  List characterList = [];

  Character currentCharacter = Character.fromJson(myCharacter);

  var httpHandler = new HttpHandler();

  var user;
  var currentCharacter_firebase;

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

  Future setCurrentCharacter(int index) async {
    currentCharacter = characterList[index];
    var character_query = await user
        .collection("Character")
        .where("name", isEqualTo: currentCharacter.name)
        .get();
    currentCharacter_firebase =
        user.collection("Character").doc(character_query.docs.first.id);
    await getSpellsCharacter(index);
    await getAbilitiesCharacter(index);
    await getNotesCharacter(index);
    await getInventoryCharacter(index);

    notifyListeners();
  }

  void addSpell(String name, int level) {
    currentCharacter_firebase
        .collection("Spell")
        .add({
          'name': name,
          'level': level,
        })
        .then((value) => print("Spell Added"))
        .catchError((error) => print("Failed to add spell: $error"));
    Spell spell = Spell(name: name, level: level);
    currentCharacter.spells.add(spell);
    currentCharacter.spells.sort(((a, b) => a.level.compareTo(b.level)));
    notifyListeners();
  }

  Future deleteSpell(int index) async {
    var spell_query = await currentCharacter_firebase.collection("Spell").get();

    for (var doc in spell_query.docs) {
      if (doc["name"] == currentCharacter.spells[index].name) {
        await doc.reference.delete();
      }
    }

    currentCharacter.spells.removeAt(index);
    notifyListeners();
  }

  Future updateSpellslot(int index, int slot) async {
    currentCharacter.spell_slots[index] = slot;
    currentCharacter_firebase
        .update({"spell_slots": currentCharacter.spell_slots})
        .then((value) => print("Spellslot Updated"))
        .catchError((error) => print("Failed to update Spellslot: $error"));

    notifyListeners();
  }

  void addNote(String title, String description) {
    currentCharacter_firebase
        .collection("Note")
        .add({
          'title': title,
          'description': description,
        })
        .then((value) => print("Note Added"))
        .catchError((error) => print("Failed to add note: $error"));

    Note note = Note(title: title, description: description);
    currentCharacter.notes.add(note);
    notifyListeners();
  }

  Future deleteNote(int index) async {
    var notes_query = await currentCharacter_firebase.collection("Note").get();

    for (var doc in notes_query.docs) {
      if (doc["title"] == currentCharacter.notes[index].title) {
        await doc.reference.delete();
      }
    }

    currentCharacter.notes.removeAt(index);
    notifyListeners();
  }

  void addItem(String name, String description, int quantity) {
    currentCharacter_firebase
        .collection("Inventory_Entry")
        .add({
          'name': name,
          'description': description,
          "quantity": quantity,
        })
        .then((value) => print("Item Added"))
        .catchError((error) => print("Failed to add item: $error"));

    InventoryEntry item =
        InventoryEntry(amount: quantity, name: name, description: description);
    currentCharacter.inventory.add(item);
    notifyListeners();
  }

  Future deleteItem(int index) async {
    var item_query =
        await currentCharacter_firebase.collection("Inventory_Entry").get();

    for (var doc in item_query.docs) {
      if (doc["name"] == currentCharacter.inventory[index].name) {
        await doc.reference.delete();
      }
    }
    currentCharacter.inventory.removeAt(index);
    notifyListeners();
  }

  Future updateAmount(int index, int amount) async {
    var item_query = await currentCharacter_firebase
        .collection("Inventory_Entry")
        .where("name", isEqualTo: currentCharacter.inventory[index].name)
        .get();

    currentCharacter_firebase
        .collection("Inventory_Entry")
        .doc(item_query.docs.first.id)
        .update({"quantity": amount})
        .then((value) => print("Item Updated"))
        .catchError((error) => print("Failed to update Item: $error"));

    currentCharacter.inventory[index].amount = amount;
    notifyListeners();
  }

  void addAbility(String name, String description) {
    currentCharacter_firebase
        .collection("Ability")
        .add({
          'name': name,
          'description': description,
        })
        .then((value) => print("Ability Added"))
        .catchError((error) => print("Failed to add ability: $error"));

    Ability ability = Ability(name: name, description: description);
    currentCharacter.abilities.add(ability);
    notifyListeners();
  }

  Future deleteAbility(int index) async {
    var ability_query =
        await currentCharacter_firebase.collection("Ability").get();

    for (var doc in ability_query.docs) {
      if (doc["name"] == currentCharacter.abilities[index].name) {
        await doc.reference.delete();
      }
    }

    currentCharacter.abilities.removeAt(index);
    notifyListeners();
  }

  Future updateProficiency(int index, int status) async {
    currentCharacter.proficiencies[index] = status;
    currentCharacter_firebase
        .update({"proficiencies": currentCharacter.proficiencies})
        .then((value) => print("Proficiency Updated"))
        .catchError((error) => print("Failed to update Proficiency: $error"));

    notifyListeners();
  }

  Future addCharacter(
      String name, String character_class, int level, String race) async {
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
        ]);

    print(character.toJson());
    await user.collection("Character").add(character.toJson());
    characterList.add(character);
    notifyListeners();
  }

  Future getCharactersList() async {
    var character_query = await user.collection("Character").get();

    for (var doc in character_query.docs) {
      var character = doc.data();
      var newcharacter = Character(
          name: character["name"],
          character_class: character["character_class"],
          level: character["level"],
          race: character["race"],
          armor_class: character["armor_class"],
          initiative: character["initiative"],
          speed: character["speed"],
          maximum_hitpoints: character["maximum_hitpoints"],
          current_hitpoints: character["current_hitpoints"],
          temporary_hitpoints: character["temporary_hitpoints"],
          hit_dice: character["hit_dice"],
          hit_dice_amount: character["hit_dice_amount"],
          strength: character["strength"],
          dexterity: character["dexterity"],
          constitution: character["constitution"],
          intelligence: character["intelligence"],
          wisdom: character["wisdom"],
          charisma: character["charisma"],
          saving_throw_proficiencies: character["saving_throw_proficiencies"],
          proficiency_bonus: character["proficiency_bonus"],
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
          ]);
      characterList.add(newcharacter);
    }

    notifyListeners();
  }

  Future getSpellsCharacter(int index) async {
    if (currentCharacter.spells.length > 0) {
      return;
    } else {
      var spell_query =
          await currentCharacter_firebase.collection("Spell").get();
      List spellList = [];
      for (var doc in spell_query.docs) {
        var spell = doc.data();
        spellList.add(Spell(name: spell["name"], level: spell["level"]));
      }
      spellList.sort(((a, b) => a.level.compareTo(b.level)));
      currentCharacter.spells = spellList;

      characterList[index].spells = spellList;
    }
    notifyListeners();
  }

  Future getAbilitiesCharacter(int index) async {
    if (currentCharacter.abilities.length > 0) {
      return;
    } else {
      var ability_query =
          await currentCharacter_firebase.collection("Ability").get();
      List abilityList = [];
      for (var doc in ability_query.docs) {
        var ability = doc.data();
        abilityList.add(Ability(
            name: ability["name"], description: ability["description"]));
      }

      currentCharacter.abilities = abilityList;
      characterList[index].abilities = abilityList;
    }
    notifyListeners();
  }

  Future getNotesCharacter(int index) async {
    if (currentCharacter.notes.length > 0) {
      return;
    } else {
      var note_query = await currentCharacter_firebase.collection("Note").get();
      List noteList = [];
      for (var doc in note_query.docs) {
        var note = doc.data();
        noteList
            .add(Note(title: note["title"], description: note["description"]));
      }
      currentCharacter.notes = noteList;
      characterList[index].notes = noteList;
    }
    notifyListeners();
  }

  Future getInventoryCharacter(int index) async {
    if (currentCharacter.inventory.length > 0) {
      return;
    } else {
      var item_query =
          await currentCharacter_firebase.collection("Inventory_Entry").get();
      List itemList = [];
      for (var doc in item_query.docs) {
        var item = doc.data();
        itemList.add(InventoryEntry(
            amount: item["quantity"],
            name: item["name"],
            description: item["description"]));
      }

      currentCharacter.inventory = itemList;
      characterList[index].inventory = itemList;
    }
    notifyListeners();
  }

  Future createUser(String email, String password, String username) async {
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
    print(password);
    await _createUserCollectionFirebase(
        FirebaseAuth.instance.currentUser!.uid, username, email);
    user = FirebaseFirestore.instance
        .collection("User")
        .doc(FirebaseAuth.instance.currentUser!.uid);
  }

  Future<void> _createUserCollectionFirebase(
      String uid, String username, String email) async {
    var userDoc =
        await FirebaseFirestore.instance.collection("User").doc(uid).get();
    // Si no exite el doc, lo crea con valor default lista vacia
    if (!userDoc.exists) {
      await FirebaseFirestore.instance.collection("User").doc(uid).set(
        {
          "username": username,
          "email": email,
        },
      );
    } else {
      // Si ya existe el doc return
      return;
    }
  }

  Future loginUser(String email, String password) async {
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      user = FirebaseFirestore.instance
          .collection("User")
          .doc(FirebaseAuth.instance.currentUser!.uid);
      await getCharactersList();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }

  Future logoutUser() async {
    characterList = [];
    characterList = [];
    await FirebaseAuth.instance.signOut();
  }

  Future<Map<String, dynamic>> getProfile() async {
    var profile = await user.get();
    print(profile.data);
    return profile.data();
  }
}
