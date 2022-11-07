import 'dart:ffi';

import 'package:character_keeper/items/data_de_increment.dart';
import 'package:character_keeper/items/data_hitpoints.dart';
import 'package:character_keeper/items/data_primary_stats.dart';
import 'package:character_keeper/items/square_stats.dart';
import 'package:character_keeper/objects/character.dart';
import 'package:character_keeper/providers/character_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DetailsCharacter extends StatelessWidget {

  const DetailsCharacter({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Character character = context.watch<Character_Provide>().currentCharacter;
    ShapeDecoration decoration_border = new ShapeDecoration(
        shape: BeveledRectangleBorder(
            side: BorderSide(
      color: Colors.black,
    )));
    var maxHitpointsController = TextEditingController();
    var currentHitpointsController = TextEditingController();
    var temporaryHitpointsController = TextEditingController();
    var hitDiceController = TextEditingController();
    return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                      width: 100,
                      height: 100,
                      child: Column(
                        children: [
                          SizedBox(height: 25),
                          Text("${character.armor_class}",
                              style: TextStyle(fontSize: 19)),
                          Text("Armor", style: TextStyle(fontSize: 14)),
                          Text("Class", style: TextStyle(fontSize: 14)),
                        ],
                      ),
                      decoration: ShapeDecoration(
                          shape: BeveledRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                              side: BorderSide(
                                color: Colors.black,
                              )))),
                  SquareData(
                      content: Character.getModifier(character.dexterity),
                      name_content: "Initiative"),
                  SquareData(
                      content: character.speed, name_content: "Speed"),
                ],
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  DataHitpoints(
                      first_title: "Maximum",
                      controller: maxHitpointsController,
                      startingValue: character.maximum_hitpoints,),
                  DataHitpoints(
                      first_title: "Current",
                      controller: currentHitpointsController,
                      startingValue: character.current_hitpoints,),
                  DataHitpoints(
                      first_title: "Temporary",
                      controller: temporaryHitpointsController,
                      startingValue: character.temporary_hitpoints),
                ],
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Container(
                      alignment: Alignment.center,
                      height: 42,
                      width: MediaQuery.of(context).size.width / 3.5,
                      decoration: decoration_border,
                      child: Text("Hit Dice ", style: TextStyle(fontSize: 14))),
                  Container(
                      alignment: Alignment.center,
                      height: 42,
                      width: 100,
                      decoration: decoration_border,
                      child: DataDeIncrement(controller: hitDiceController, startingValue: character.hit_dice_amount,)),
                  Container(
                      alignment: Alignment.center,
                      height: 42,
                      width: 81,
                      decoration: decoration_border,
                      child: Text("${character.hit_dice}")),
                ],
              ),
              SizedBox(height: 10),
              Container(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          DataPrimaryStats(
                              stat: "Strength",
                              stat_modifier: Character.getStringModifier(character.strength),
                              stat_number: character.strength,
                              proficiency: character.saving_throw_proficiencies[0],
                              ),
                          DataPrimaryStats(
                              stat: "Dexterity",
                              stat_modifier: Character.getStringModifier(character.dexterity),
                              stat_number: character.dexterity,
                              proficiency: character.saving_throw_proficiencies[1],
                              ),
                          DataPrimaryStats(
                              stat: "Constitution",
                              stat_modifier: Character.getStringModifier(character.constitution),
                              stat_number: character.constitution,
                              proficiency: character.saving_throw_proficiencies[2],
                              ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          DataPrimaryStats(
                              stat: "Intelligence",
                              stat_modifier: Character.getStringModifier(character.intelligence),
                              stat_number: character.intelligence,
                              proficiency: character.saving_throw_proficiencies[3],
                              ),
                          DataPrimaryStats(
                              stat: "Wisdom",
                              stat_modifier: Character.getStringModifier(character.wisdom),
                              stat_number: character.wisdom,
                              proficiency: character.saving_throw_proficiencies[4],
                              ),
                          DataPrimaryStats(
                              stat: "Charisma",
                              stat_modifier: Character.getStringModifier(character.charisma),
                              stat_number: character.charisma,
                              proficiency: character.saving_throw_proficiencies[5],
                              ),
                        ],
                      )
                    ],
                  ),
                  decoration: decoration_border),
                          ]),
          ),
        );
  }
}
