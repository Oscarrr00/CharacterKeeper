import 'package:character_keeper/objects/ability.dart';
import 'package:character_keeper/objects/inventory_entry.dart';
import 'package:character_keeper/objects/note.dart';
import 'package:character_keeper/objects/proficiencies.dart';
import 'package:character_keeper/objects/spell.dart';

class Character {
  String name = "My character";
  String race = "Human";
  String character_class = "Fighter";
  int level = 1;
  int armor_class = 15;
  int initiative = 2;
  int speed = 30;
  int maximum_hitpoints = 10;
  int current_hitpoints = 10;
  int temporary_hitpoints = 0;
  String hit_dice = "d10";
  int hit_dice_amount = 1;

  int strength;
  int dexterity;
  int constitution;
  int intelligence;
  int wisdom;
  int charisma;
  var saving_throw_proficiencies = [];

  int proficiency_bonus;
  var proficiencies = [];

  var spells = [];
  var abilities = [];
  var inventory = [];
  var notes = [];

  var spell_slots = [];

  Character({
    required this.name,
    required this.race,
    required this.character_class,
    required this.level,
    required this.armor_class,
    required this.initiative,
    required this.speed,
    required this.maximum_hitpoints,
    required this.current_hitpoints,
    required this.temporary_hitpoints,
    required this.hit_dice,
    required this.hit_dice_amount,
    required this.strength,
    required this.dexterity,
    required this.constitution,
    required this.intelligence,
    required this.wisdom,
    required this.charisma,
    required this.saving_throw_proficiencies,
    required this.proficiency_bonus,
    required this.proficiencies,
    required this.abilities,
    required this.inventory,
    required this.spells,
    required this.notes,
    required this.spell_slots,
  });

  factory Character.fromJson(Map<String, dynamic> json) {
    int i = 0;
    var spells = [];
    for (i = 0; i < json["spells"].length; i++) {
      spells.add(Spell(
          level: json["spells"][i]["level"], name: json["spells"][i]["name"]));
    }

    var abilities = [];
    for (i = 0; i < json["abilities"].length; i++) {
      abilities.add(Ability(
          name: json["abilities"][i]["name"],
          description: json["abilities"][i]["description"]));
    }

    var inventory = [];
    for (i = 0; i < json["inventory"].length; i++) {
      inventory.add(InventoryEntry(
          amount: json["inventory"][i]["amount"],
          name: json["inventory"][i]["name"],
          description: json["inventory"][i]["description"]));
    }

    var notes = [];
    for (i = 0; i < json["notes"].length; i++) {
      notes.add(Note(
          title: json["notes"][i]["title"],
          description: json["notes"][i]["description"]));
    }

    return Character(
      name: json["name"],
      race: json["race"],
      character_class: json["character_class"],
      level: json["level"],
      armor_class: json["armor_class"],
      initiative: json["initiative"],
      speed: json["speed"],
      maximum_hitpoints: json["maximum_hitpoints"],
      current_hitpoints: json["current_hitpoints"],
      temporary_hitpoints: json["temporary_hitpoints"],
      hit_dice: json["hit_dice"],
      hit_dice_amount: json["hit_dice_amount"],
      strength: json["strength"],
      dexterity: json["dexterity"],
      constitution: json["constitution"],
      intelligence: json["intelligence"],
      wisdom: json["wisdom"],
      charisma: json["charisma"],
      saving_throw_proficiencies: json["saving_throw_proficiencies"],
      proficiency_bonus: json["proficiency_bonus"],
      proficiencies: json["proficiencies"],
      spells: spells,
      abilities: abilities,
      inventory: inventory,
      notes: notes,
      spell_slots: json["spell_slots"],
    );
  }

  static int getModifier(int score) {
    score = score - (score % 2);
    score -= 10;
    score = score ~/ 2;

    return score;
  }

  static String getStringModifier(int score) {
    score = getModifier(score);
    return score >= 0 ? "+${score}" : "${score}";
  }
}

const myCharacter = {
  "name": "Déndillon",
  "race": "Human",
  "character_class": "Bard",
  "level": 5,
  "armor_class": 15,
  "initiative": 2,
  "speed": 30,
  "maximum_hitpoints": 40,
  "current_hitpoints": 35,
  "temporary_hitpoints": 0,
  "hit_dice": "d8",
  "hit_dice_amount": 5,
  "strength": 8,
  "dexterity": 14,
  "constitution": 14,
  "intelligence": 10,
  "wisdom": 12,
  "charisma": 18,
  "saving_throw_proficiencies": [0, 1, 0, 0, 0, 1],
  "proficiency_bonus": 3,
  "proficiencies": [1, 0, 0, 0, 1, 0, 2, 0, 0, 0, 0, 1, 1, 1, 0, 1, 1, 2],
  "spells": [
    {"level": 0, "name": "Vicious Mockery"},
    {"level": 1, "name": "Charm Person"},
    {"level": 2, "name": "Hold Person"}
  ],
  "abilities": [
    {
      "name": "Eldritch Adept",
      "description":
          "You can cast the 'Disguise Self' spell at will without consuming a spell slot."
    },
    {
      "name": "Jack of All Trades",
      "description":
          "You can add half your proficiency bonus (rounded down) to all ability checks that you aren't proficient in already."
    }
  ],
  "inventory": [
    {
      "amount": 1,
      "name": "Lute",
      "description":
          "If you have proficiency with a given musical instrument, you can add your proficiency bonus to any ability checks you make to play music with the instrument. A bard can use a musical instrument as a spellcasting focus. Each type of musical instrument requires a separate proficiency."
    },
    {
      "amount": 10,
      "name": "Torch",
      "description":
          "A torch burns for 1 hour, providing bright light in a 20-foot radius and dim light for an additional 20 feet. If you make a melee attack with a burning torch and hit, it deals 1 fire damage."
    }
  ],
  "notes": [
    {
      "title": "How to defeat Strahd",
      "description":
          "Strahd is known to be weak to sunlight, running water and radiant damage."
    },
    {
      "title": "Khazan, the Sunsword",
      "description":
          "Khazan is currently under Strahd's possesion, and is probably being held at Castle Ravenloft."
    }
  ],
  "spell_slots": [
    [4, 1],
    [3, 1],
    [2, 1],
    [0, 0],
    [0, 0],
    [0, 0],
    [0, 0],
    [0, 0],
    [0, 0]
  ]
};
