import 'package:character_keeper/items/proficiency_circle_skill.dart';
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
            Expanded(
                child: Container(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "PROFICIENCY BONUS",
                        style: Theme.of(context).textTheme.headline6,
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
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.secondary,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                            child: Center(
                                child: Text(
                          "SKILL PROFICIENCIES",
                          style: Theme.of(context).textTheme.headline6,
                        )))
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
                          (index) => Padding(
                                padding: const EdgeInsets.only(bottom: 6.0),
                                child: Container(
                                  padding: EdgeInsets.only(
                                      top: 4, right: 8, bottom: 4, left: 4),
                                  decoration: BoxDecoration(
                                    color:
                                        Theme.of(context).colorScheme.secondary,
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  child: Row(
                                    children: [
                                      Expanded(
                                          child: Row(
                                        children: [
                                          Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: ProficiencyCircleSkill(
                                                  status: character
                                                      .proficiencies[index],
                                                  radius: 10,
                                                  index: index)),
                                          Text(proficiencies[index][2] + "   ",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold)),
                                          Expanded(
                                              child: Text(
                                                  proficiencies[index][0])),
                                          Text(proficiencies[index][1],
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold))
                                        ],
                                      )),
                                    ],
                                  ),
                                ),
                              )),
                    ),
                  ))
                ],
              ),
            )),
          ],
        ),
      ),
    );
  }
}
