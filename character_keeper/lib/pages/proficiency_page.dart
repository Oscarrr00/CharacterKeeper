import 'package:character_keeper/items/proficiency_circle.dart';
import 'package:character_keeper/objects/character.dart';
import 'package:character_keeper/providers/character_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProficiencyPage extends StatelessWidget {

  Character character;
  ProficiencyPage({required this.character});

  @override
  Widget build(BuildContext context) {

    character = context.watch<Character_Provide>().currentCharacter;

    String str = Character.getStringModifier(character.strength);
    String dex = Character.getStringModifier(character.dexterity);
    String int = Character.getStringModifier(character.intelligence);
    String wis = Character.getStringModifier(character.wisdom);
    String cha = Character.getStringModifier(character.charisma);

  List proficiencies = [
    ["Acrobatics", "DEX", dex],
    ["Animal Handling", "WIS", wis],
    ["Arcana", "INT", int],
    ["Athletics", "STR", str],
    ["Deception", "CHA", cha],
    ["History", "INT", int],
    ["Insight", "WIS", wis],
    ["Intimidation", "CHA", cha],
    ["Investigation", "INT", int],
    ["Medicine", "WIS", wis],
    ["Nature", "INT", int],
    ["Perception", "WIS", wis],
    ["Performance", "CHA", cha],
    ["Persuasion", "CHA", cha],
    ["Religion", "INT", int],
    ["Sleight Of Hand", "DEX", dex],
    ["Stealth", "DEX", dex],
    ["Survival", "WIS", wis]
  ];


    return Container(
          child: Padding(
        padding: EdgeInsets.all(8),
        child: Column(
          children: [
            Center(
                child: Text(
              "Skill Proficiencies",
              style: Theme.of(context).textTheme.headline6,
            )),
            Expanded(
                child: Card(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Proficiency Bonus",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CircleAvatar(
                          backgroundColor:
                              Theme.of(context).colorScheme.primary,
                          child: Text(
                            "+${character.proficiency_bonus}",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      )
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.all(8),
                    color: Theme.of(context).colorScheme.secondary,
                    child: Row(
                      children: [
                        Expanded(
                            child: Center(
                                child: Text("Skill Proficiencies",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold))))
                      ],
                    ),
                  ),
                  Expanded(
                      child: Padding(
                    padding: EdgeInsets.all(8),
                    child: GridView.count(
                      crossAxisCount: 1,
                      mainAxisSpacing: 4,
                      childAspectRatio: 7.0,
                      children: List.generate(
                          18,
                          (index) => Container(
                                padding: EdgeInsets.all(4),
                                color: index % 2 == 1 ? Colors.grey[350] : null,
                                child: Row(
                                  children: [
                                    Expanded(
                                        child: Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: ProficiencyCircle(
                                            status: character.proficiencies[index],
                                            radius: 10
                                          )
                                        ),                                        
                                        Text(proficiencies[index][2] + "   ", style: TextStyle(
                                                fontWeight: FontWeight.bold)),
                                        Expanded(child: Text(proficiencies[index][0])),
                                        Text(proficiencies[index][1],
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold))
                                      ],
                                    )),
                                  ],
                                ),
                              )),
                    ),
                  ))
                ],
              ),
            )),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                      child: Text("Edit Proficiencies"), onPressed: () {}),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}


