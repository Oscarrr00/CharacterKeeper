import 'dart:ffi';

import 'package:character_keeper/items/data_de_increment.dart';
import 'package:character_keeper/items/data_hitpoints.dart';
import 'package:character_keeper/items/data_primary_stats.dart';
import 'package:character_keeper/items/square_data_edit.dart';
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
    hitDiceController.text = "${character.hit_dice_amount}";
    var armor_classController = TextEditingController();
    var dexterityController = TextEditingController();
    dexterityController.text = "${character.dexterity}";
    var intelligenceController = TextEditingController();
    intelligenceController.text = "${character.intelligence}";
    var strengthController = TextEditingController();
    strengthController.text = "${character.strength}";
    var constitutionController = TextEditingController();
    constitutionController.text = "${character.constitution}";
    var wisdomController = TextEditingController();
    wisdomController.text = "${character.wisdom}";
    var charismaController = TextEditingController();
    charismaController.text = "${character.charisma}";

    var speedController = TextEditingController();
    speedController.text = "${character.speed}";

    var hitDiceNumberController = TextEditingController();
    hitDiceNumberController.text = character.hit_dice;
    armor_classController.text = "${character.armor_class}";
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
                      SizedBox(
                        height: 45,
                        width: 35,
                        child: TextFormField(
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 21),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                          ),
                          controller: armor_classController,
                          keyboardType: TextInputType.numberWithOptions(
                            decimal: false,
                          ),
                          onFieldSubmitted: (value) {
                            int num = int.parse(value);
                            context
                                .read<Character_Provide>()
                                .updateArmorClass(num);
                          },
                        ),
                      ),
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
              SquareDataEdit(
                  name_content: "Speed", controller: speedController),
            ],
          ),
          SizedBox(height: 10),
          Row(
            children: [
              DataHitpoints(
                  first_title: "Maximum",
                  controller: maxHitpointsController,
                  startingValue: character.maximum_hitpoints,
                  nameValue: "maximum_hitpoints"),
              DataHitpoints(
                  first_title: "Current",
                  controller: currentHitpointsController,
                  startingValue: character.current_hitpoints,
                  nameValue: "current_hitpoints"),
              DataHitpoints(
                  first_title: "Temporary",
                  controller: temporaryHitpointsController,
                  startingValue: character.temporary_hitpoints,
                  nameValue: "temporary_hitpoints"),
            ],
          ),
          SizedBox(height: 10),
          Row(
            children: [
              Container(
                  alignment: Alignment.center,
                  height: 42,
                  width: MediaQuery.of(context).size.width / 3.6,
                  decoration: decoration_border,
                  child: Text("Hit Dice ", style: TextStyle(fontSize: 14))),
              Container(
                  alignment: Alignment.center,
                  height: 42,
                  width: MediaQuery.of(context).size.width / 3.6,
                  decoration: decoration_border,
                  child: DataDeIncrement(
                      controller: hitDiceController,
                      nameValue: "hit_dice_amount")),
              Container(
                alignment: Alignment.center,
                height: 42,
                width: MediaQuery.of(context).size.width / 3.6,
                decoration: decoration_border,
                child: SizedBox(
                  height: 30,
                  width: 35,
                  child: TextFormField(
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                    ),
                    controller: hitDiceNumberController,
                    onFieldSubmitted: (value) {
                      context.read<Character_Provide>().updateHitDice(value);
                    },
                  ),
                ),
              ),
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
                          stat_modifier:
                              Character.getStringModifier(character.strength),
                          proficiency: character.saving_throw_proficiencies[0],
                          controller: strengthController),
                      DataPrimaryStats(
                          stat: "Dexterity",
                          stat_modifier:
                              Character.getStringModifier(character.dexterity),
                          proficiency: character.saving_throw_proficiencies[1],
                          controller: dexterityController),
                      DataPrimaryStats(
                          stat: "Constitution",
                          stat_modifier: Character.getStringModifier(
                              character.constitution),
                          proficiency: character.saving_throw_proficiencies[2],
                          controller: constitutionController),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      DataPrimaryStats(
                          stat: "Intelligence",
                          stat_modifier: Character.getStringModifier(
                              character.intelligence),
                          proficiency: character.saving_throw_proficiencies[3],
                          controller: intelligenceController),
                      DataPrimaryStats(
                          stat: "Wisdom",
                          stat_modifier:
                              Character.getStringModifier(character.wisdom),
                          proficiency: character.saving_throw_proficiencies[4],
                          controller: wisdomController),
                      DataPrimaryStats(
                          stat: "Charisma",
                          stat_modifier:
                              Character.getStringModifier(character.charisma),
                          proficiency: character.saving_throw_proficiencies[5],
                          controller: charismaController),
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
