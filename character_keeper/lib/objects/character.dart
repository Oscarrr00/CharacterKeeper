import 'package:character_keeper/objects/proficiencies.dart';

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

   int proficiency_bonus;
   var proficiencies = [];



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

   required this.proficiency_bonus,
   required this.proficiencies,
  });

  factory Character.fromJson(Map<String, dynamic> json)
  {
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
      proficiency_bonus: json["proficiency_bonus"],
      proficiencies: json["proficiencies"]
    );

  }

  static int getModifier(int score)
  {
    score = score -(score % 2);
    score -= 10;
    score = score ~/ 2;

    return score;
  }

  static String getStringModifier(int score)
  {
    score = getModifier(score);
    return score >= 0 ? "+${score}" : "${score}";
  }

}

const myCharacter = 
{
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
  "proficiency_bonus": 3,
  "proficiencies": [
    1,
    0,
    0,
    0,
    1,
    0,
    2,
    0,
    0,
    0,
    0,
    1,
    1,
    1,
    0,
    1,
    1,
    0
  ],
  

};

