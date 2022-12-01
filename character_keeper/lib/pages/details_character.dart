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
    var initiativeController = TextEditingController();
    initiativeController.text = "${Character.getModifier(character.dexterity)}";

    var hitDiceNumberController = TextEditingController();
    hitDiceNumberController.text = character.hit_dice;
    armor_classController.text = "${character.armor_class}";
    return SingleChildScrollView(
      child: Column(children: [
        Container(
          padding: EdgeInsets.all(15),
          color: Theme.of(context).colorScheme.secondary,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 13,
                        width: 35,
                        child: TextFormField(
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: MediaQuery.of(context).size.height / 31,
                          ),
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
                      Text("ARMOR CLASS",
                          style: Theme.of(context).textTheme.headline3),
                    ],
                  ),
                  SizedBox(width: 15),
                  SquareData(
                      controller: initiativeController,
                      name_content: "INITIATIVE"),
                  SizedBox(width: 15),
                  SquareDataEdit(
                      name_content: "FT. SPEED", controller: speedController),
                ],
              ),
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  DataHitpoints(
                      first_title: "Temporary",
                      controller: temporaryHitpointsController,
                      startingValue: character.temporary_hitpoints,
                      nameValue: "temporary_hitpoints"),
                  DataHitpoints(
                      first_title: "Current",
                      controller: currentHitpointsController,
                      startingValue: character.current_hitpoints,
                      nameValue: "current_hitpoints"),
                  DataHitpoints(
                      first_title: "Maximum",
                      controller: maxHitpointsController,
                      startingValue: character.maximum_hitpoints,
                      nameValue: "maximum_hitpoints"),
                ],
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      alignment: Alignment.center,
                      height: 42,
                      width: MediaQuery.of(context).size.width / 4,
                      child: Text(
                        "CURRENT\nHIT DICE ",
                        style: Theme.of(context).textTheme.headline3,
                        textAlign: TextAlign.center,
                      )),
                  Container(
                      alignment: Alignment.center,
                      height: 42,
                      width: MediaQuery.of(context).size.width / 4,
                      child: DataDeIncrement(
                          controller: hitDiceController,
                          nameValue: "hit_dice_amount")),
                  Container(
                    width: MediaQuery.of(context).size.width / 4,
                    child: SizedBox(
                      height: 50,
                      width: 35,
                      child: TextFormField(
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headline2,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                        ),
                        controller: hitDiceNumberController,
                        onFieldSubmitted: (value) {
                          context
                              .read<Character_Provide>()
                              .updateHitDice(value);
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
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
                      stat_modifier:
                          Character.getStringModifier(character.constitution),
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
                      stat_modifier:
                          Character.getStringModifier(character.intelligence),
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
        ),
      ]),
    );
  }
}
