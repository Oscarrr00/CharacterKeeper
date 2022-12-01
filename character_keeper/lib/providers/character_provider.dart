import 'dart:io';

import 'package:character_keeper/http_handler.dart';
import 'package:character_keeper/objects/ability.dart';
import 'package:character_keeper/objects/character.dart';
import 'package:character_keeper/objects/inventory_entry.dart';
import 'package:character_keeper/objects/note.dart';
import 'package:character_keeper/objects/spell.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class Character_Provide with ChangeNotifier {
  List characterList = [];

  Character currentCharacter = Character.fromJson(myCharacter);

  var displayInventory = [];
  var displayNotes = [];
  var displayAbilities = [];

  var httpHandler = new HttpHandler();

  var user;
  dynamic profile;
  bool userLoggedData = false;
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

    displayInventory = currentCharacter.inventory;
    displayNotes = currentCharacter.notes;
    displayAbilities = currentCharacter.abilities;

    notifyListeners();
  }

  // Aqui es donde se agrega los personajes y sus contenidos ===============================================================
  ////////////////////////////////
  ///
  ///
  ///

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

  void addNote(String title, String description, String image) async {
    String imageURL = "";
    if (image != "") {
      File file = File(image);
      var userDoc = await user.get();
      var userData = userDoc.data();
      String username = userData["username"];
      String imagePath = 'images/' + username + (DateTime.now().toString());

      dynamic taskref = FirebaseStorage.instance.ref().child(imagePath);
      await taskref.putFile(file);
      imageURL = await taskref.getDownloadURL();
    }

    currentCharacter_firebase
        .collection("Note")
        .add({'title': title, 'description': description, 'image': imageURL})
        .then((value) => print("Note Added"))
        .catchError((error) => print("Failed to add note: $error"));

    Note note = Note(title: title, description: description, image: imageURL);
    currentCharacter.notes.add(note);
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

  //Aqui estaran todas las funciones de eliminar los contenidos =======================================================
  ////////////////////////////////
  ///
  ///
  ///

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

  Future deleteNote(int index) async {
    var notes_query = await currentCharacter_firebase.collection("Note").get();

    for (var doc in notes_query.docs) {
      if (doc["title"] == displayNotes[index].title) {
        await doc.reference.delete();
      }
    }

    currentCharacter.notes.remove(displayNotes[index]);
    notifyListeners();
  }

  Future deleteItem(int index) async {
    var item_query =
        await currentCharacter_firebase.collection("Inventory_Entry").get();

    for (var doc in item_query.docs) {
      if (doc["name"] == displayInventory[index].name) {
        await doc.reference.delete();
      }
    }
    currentCharacter.inventory.remove(displayInventory[index]);
    notifyListeners();
  }

  Future deleteAbility(int index) async {
    var ability_query =
        await currentCharacter_firebase.collection("Ability").get();

    for (var doc in ability_query.docs) {
      if (doc["name"] == displayAbilities[index].name) {
        await doc.reference.delete();
      }
    }

    currentCharacter.abilities.remove(displayAbilities[index]);
    notifyListeners();
  }

  Future deleteCharacter(int index) async {
    var character_query = await user.collection("Character").get();
    var characaterToDelete = characterList[index].toJson();
    for (var doc in character_query.docs) {
      var character = doc.data();

      if (character["name"] == characaterToDelete["name"] &&
          character["level"] == characaterToDelete["level"] &&
          character["race"] == characaterToDelete["race"] &&
          character["character_class"] ==
              characaterToDelete["character_class"]) {
        print("Si se igualo");
        await doc.reference.delete();
      }
    }

    characterList.removeAt(index);

    notifyListeners();
  }

  //Aqui iria los updates que se hacen en la pagina =============================================================
  ////////////////////////////////
  ///
  ///
  ///
  ///

  void updateSpellslot(int index, int slot) {
    currentCharacter.spell_slots[index] = slot;
    currentCharacter_firebase
        .update({"spell_slots": currentCharacter.spell_slots})
        .then((value) => print("Spellslot Updated"))
        .catchError((error) => print("Failed to update Spellslot: $error"));

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

  void updateProficiency(int index, int status) {
    currentCharacter.proficiencies[index] = status;
    currentCharacter_firebase
        .update({"proficiencies": currentCharacter.proficiencies})
        .then((value) => print("Proficiency Updated"))
        .catchError((error) => print("Failed to update Proficiency: $error"));

    notifyListeners();
  }

  void updateHitpoints(String nameValue, int num) {
    if (nameValue == "maximum_hitpoints") {
      currentCharacter.maximum_hitpoints = num;
      currentCharacter_firebase
          .update({"maximum_hitpoints": num})
          .then((value) => print("maximum_hitpoints Updated"))
          .catchError(
              (error) => print("Failed to update maximum_hitpoints: $error"));
    } else if (nameValue == "current_hitpoints") {
      currentCharacter.current_hitpoints = num;
      currentCharacter_firebase
          .update({"current_hitpoints": num})
          .then((value) => print("current_hitpoints Updated"))
          .catchError(
              (error) => print("Failed to update current_hitpoints: $error"));
    } else if (nameValue == "temporary_hitpoints") {
      currentCharacter.temporary_hitpoints = num;
      currentCharacter_firebase
          .update({"temporary_hitpoints": num})
          .then((value) => print("temporary_hitpoints Updated"))
          .catchError(
              (error) => print("Failed to update temporary_hitpoints: $error"));
    } else {
      currentCharacter.hit_dice_amount = num;
      currentCharacter_firebase
          .update({"hit_dice_amount": num})
          .then((value) => print("hit_dice_amount Updated"))
          .catchError(
              (error) => print("Failed to update hit_dice_amount: $error"));
    }
    notifyListeners();
  }

  void updateHitDice(String value) {
    currentCharacter.hit_dice = value;
    currentCharacter_firebase
        .update({"hit_dice": value})
        .then((value) => print("hit_dice Updated"))
        .catchError((error) => print("Failed to update hit_dice: $error"));
    notifyListeners();
  }

  void updateSpeed(int num) {
    currentCharacter.speed = num;
    currentCharacter_firebase
        .update({"speed": num})
        .then((value) => print("Speed Updated"))
        .catchError((error) => print("Failed to update Speed: $error"));
    notifyListeners();
  }

  void updateArmorClass(int num) {
    currentCharacter.armor_class = num;
    currentCharacter_firebase
        .update({"armor_class": num})
        .then((value) => print("Armor_class Updated"))
        .catchError((error) => print("Failed to update Armor_class: $error"));
    notifyListeners();
  }

  void updateStatPrimary(int num, String nameValue) {
    if (nameValue == "Strength") {
      currentCharacter.strength = num;
      currentCharacter_firebase
          .update({"strength": num})
          .then((value) => print("strength Updated"))
          .catchError((error) => print("Failed to update strength: $error"));
    } else if (nameValue == "Dexterity") {
      currentCharacter.dexterity = num;
      currentCharacter_firebase
          .update({"dexterity": num})
          .then((value) => print("Dexterity Updated"))
          .catchError((error) => print("Failed to update Dexterity: $error"));
    } else if (nameValue == "Wisdom") {
      currentCharacter.wisdom = num;
      currentCharacter_firebase
          .update({"wisdom": num})
          .then((value) => print("Wisdom Updated"))
          .catchError((error) => print("Failed to update Wisdom: $error"));
    } else if (nameValue == "Charisma") {
      currentCharacter.charisma = num;
      currentCharacter_firebase
          .update({"charisma": num})
          .then((value) => print("Charisma Updated"))
          .catchError((error) => print("Failed to update Charisma: $error"));
    } else if (nameValue == "Constitution") {
      currentCharacter.constitution = num;
      currentCharacter_firebase
          .update({"constitution": num})
          .then((value) => print("Constitution Updated"))
          .catchError(
              (error) => print("Failed to update Constitution: $error"));
    } else {
      currentCharacter.intelligence = num;
      currentCharacter_firebase
          .update({"intelligence": num})
          .then((value) => print("Intelligence Updated"))
          .catchError(
              (error) => print("Failed to update Intelligence: $error"));
    }
    notifyListeners();
  }

  void updateSavingThrows(int status, String stat) {
    if (stat == "Strength") {
      currentCharacter.saving_throw_proficiencies[0] = status;
      currentCharacter_firebase
          .update({
            "saving_throw_proficiencies":
                currentCharacter.saving_throw_proficiencies
          })
          .then((value) => print("Saving_throw_proficiencies Updated"))
          .catchError((error) =>
              print("Failed to update Saving_throw_proficiencies: $error"));
    } else if (stat == "Dexterity") {
      currentCharacter.saving_throw_proficiencies[1] = status;
      currentCharacter_firebase
          .update({
            "saving_throw_proficiencies":
                currentCharacter.saving_throw_proficiencies
          })
          .then((value) => print("Saving_throw_proficiencies Updated"))
          .catchError((error) =>
              print("Failed to update Saving_throw_proficiencies: $error"));
    } else if (stat == "Wisdom") {
      currentCharacter.saving_throw_proficiencies[4] = status;
      currentCharacter_firebase
          .update({
            "saving_throw_proficiencies":
                currentCharacter.saving_throw_proficiencies
          })
          .then((value) => print("Saving_throw_proficiencies Updated"))
          .catchError((error) =>
              print("Failed to update Saving_throw_proficiencies: $error"));
    } else if (stat == "Charisma") {
      currentCharacter.saving_throw_proficiencies[5] = status;
      currentCharacter_firebase
          .update({
            "saving_throw_proficiencies":
                currentCharacter.saving_throw_proficiencies
          })
          .then((value) => print("Saving_throw_proficiencies Updated"))
          .catchError((error) =>
              print("Failed to update Saving_throw_proficiencies: $error"));
    } else if (stat == "Constitution") {
      currentCharacter.saving_throw_proficiencies[2] = status;
      currentCharacter_firebase
          .update({
            "saving_throw_proficiencies":
                currentCharacter.saving_throw_proficiencies
          })
          .then((value) => print("Saving_throw_proficiencies Updated"))
          .catchError((error) =>
              print("Failed to update Saving_throw_proficiencies: $error"));
    } else {
      currentCharacter.saving_throw_proficiencies[3] = status;
      currentCharacter_firebase
          .update({
            "saving_throw_proficiencies":
                currentCharacter.saving_throw_proficiencies
          })
          .then((value) => print("Saving_throw_proficiencies Updated"))
          .catchError((error) =>
              print("Failed to update Saving_throw_proficiencies: $error"));
    }
    notifyListeners();
  }

  Future updateNote(int index, String title, String description) async {
    var item_query = await currentCharacter_firebase
        .collection("Note")
        .where("title", isEqualTo: currentCharacter.notes[index].title)
        .where("description",
            isEqualTo: currentCharacter.notes[index].description)
        .get();

    currentCharacter_firebase
        .collection("Note")
        .doc(item_query.docs.first.id)
        .update({
          "title": title,
          "description": description,
          "image": currentCharacter.notes[index].image
        })
        .then((value) => print("Note Updated"))
        .catchError((error) => print("Failed to update Note: $error"));

    currentCharacter.notes[index].title = title;
    currentCharacter.notes[index].description = description;
    notifyListeners();
  }

  Future updateItem(
      int index, String name, String description, int quantity) async {
    var item_query = await currentCharacter_firebase
        .collection("Inventory_Entry")
        .where("name", isEqualTo: currentCharacter.inventory[index].name)
        .where("description",
            isEqualTo: currentCharacter.inventory[index].description)
        .get();

    currentCharacter_firebase
        .collection("Inventory_Entry")
        .doc(item_query.docs.first.id)
        .update(
            {"name": name, "description": description, "quantity": quantity})
        .then((value) => print("Inventory Entry Updated"))
        .catchError(
            (error) => print("Failed to update Inventory Entry: $error"));

    currentCharacter.inventory[index].name = name;
    currentCharacter.inventory[index].description = description;
    notifyListeners();
  }

  Future updateAbility(int index, String name, String description) async {
    var item_query = await currentCharacter_firebase
        .collection("Ability")
        .where("name", isEqualTo: currentCharacter.abilities[index].name)
        .where("description",
            isEqualTo: currentCharacter.abilities[index].description)
        .get();

    currentCharacter_firebase
        .collection("Ability")
        .doc(item_query.docs.first.id)
        .update({"name": name, "description": description})
        .then((value) => print("Ability Entry Updated"))
        .catchError((error) => print("Failed to update Ability Entry: $error"));

    currentCharacter.abilities[index].name = name;
    currentCharacter.abilities[index].description = description;
    notifyListeners();
  }

  void updateUsername(String username) {
    user = FirebaseFirestore.instance
        .collection("User")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({"username": username})
        .then((value) => print("Username Updated"))
        .catchError((error) => print("Failed to update Username: $error"));

    profile["username"] = username;
    notifyListeners();
  }

  // Aqui es para obtener el contenido de lo que tiene el usuario ============================================================
  ////////////////////////////////
  ///
  ///
  ///

  Future getCharactersList() async {
    var character_query = await user.collection("Character").get();
    characterList = [];
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
          proficiencies: character["proficiencies"],
          abilities: [],
          inventory: [],
          spells: [],
          notes: [],
          spell_slots: character["spell_slots"]);
      characterList.add(newcharacter);
    }
    print("Aqui es cuando los agarro: ${characterList}");
    userLoggedData = true;
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
        noteList.add(Note(
            title: note["title"],
            description: note["description"],
            image: note["image"]));
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

  //Esta parte es para la creacion y loguearse con usuarios =======================================================
  ////////////////////////////////
  ///
  ///
  ///

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
    userLoggedData = true;
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
    if (FirebaseAuth.instance.currentUser != null) {
      user = FirebaseFirestore.instance
          .collection("User")
          .doc(FirebaseAuth.instance.currentUser!.uid);
      await getCharactersList();
    } else {
      try {
        final credential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password);
        user = FirebaseFirestore.instance
            .collection("User")
            .doc(FirebaseAuth.instance.currentUser!.uid);
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          print('No user found for that email.');
        } else if (e.code == 'wrong-password') {
          print('Wrong password provided for that user.');
        }
      }
    }
  }

  Future logoutUser() async {
    characterList = [];

    userLoggedData = false;
    await FirebaseAuth.instance.signOut();
    notifyListeners();
  }

  Future getProfile() async {
    profile = await user.get();
    profile = profile.data();
  }

//Esta parte es para la busqueda de las cosas==============================================
////////////////////////////////
  ///
  ///
  ///

  void searchItem(String name) {
    if (name == "") {
      displayInventory = currentCharacter.inventory;
    }
    name = name.toLowerCase();
    List result = [];
    for (var item in currentCharacter.inventory) {
      if (item.name.toLowerCase().contains(name) ||
          item.description.toLowerCase().contains(name)) {
        result.add(item);
      }
    }
    displayInventory = result;
    notifyListeners();
  }

  void searchNote(String name) {
    if (name == "") {
      displayNotes = currentCharacter.notes;
    }
    name = name.toLowerCase();
    List result = [];
    for (var note in currentCharacter.notes) {
      if (note.title.toLowerCase().contains(name) ||
          note.description.toLowerCase().contains(name)) {
        result.add(note);
      }
    }
    displayNotes = result;
    notifyListeners();
  }

  void searchAbility(String name) {
    if (name == "") {
      displayAbilities = currentCharacter.abilities;
    }
    name = name.toLowerCase();
    List result = [];
    for (var ability in currentCharacter.abilities) {
      if (ability.name.toLowerCase().contains(name) ||
          ability.description.toLowerCase().contains(name)) {
        result.add(ability);
      }
    }
    displayAbilities = result;
    notifyListeners();
  }
}
