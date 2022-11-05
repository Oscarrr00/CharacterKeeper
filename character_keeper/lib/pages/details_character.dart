import 'dart:ffi';

import 'package:character_keeper/items/data_de_increment.dart';
import 'package:character_keeper/items/data_hitpoints.dart';
import 'package:character_keeper/items/data_primary_stats.dart';
import 'package:character_keeper/items/square_stats.dart';
import 'package:character_keeper/objects/character.dart';
import 'package:flutter/material.dart';

class DetailsCharacter extends StatelessWidget {
  final Character character;
  const DetailsCharacter({
    Key? key,
    required this.character,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                      controller: maxHitpointsController),
                  DataHitpoints(
                      first_title: "Current",
                      controller: currentHitpointsController),
                  DataHitpoints(
                      first_title: "Temporary",
                      controller: temporaryHitpointsController),
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
                      child: DataDeIncrement(controller: hitDiceController)),
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
                              stat_number: character.strength),
                          DataPrimaryStats(
                              stat: "Dexterity",
                              stat_modifier: Character.getStringModifier(character.dexterity),
                              stat_number: character.dexterity),
                          DataPrimaryStats(
                              stat: "Constitution",
                              stat_modifier: Character.getStringModifier(character.constitution),
                              stat_number: character.constitution),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          DataPrimaryStats(
                              stat: "Intelligence",
                              stat_modifier: Character.getStringModifier(character.intelligence),
                              stat_number: character.intelligence),
                          DataPrimaryStats(
                              stat: "Wisdom",
                              stat_modifier: Character.getStringModifier(character.wisdom),
                              stat_number: character.wisdom),
                          DataPrimaryStats(
                              stat: "Charisma",
                              stat_modifier: Character.getStringModifier(character.charisma),
                              stat_number: character.charisma),
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
