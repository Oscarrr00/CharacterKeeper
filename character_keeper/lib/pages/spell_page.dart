import 'package:character_keeper/items/data_de_incremente_smaller.dart';
import 'package:character_keeper/items/input_text.dart';
import 'package:character_keeper/providers/character_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SpellPage extends StatelessWidget {
  const SpellPage({super.key});

  @override
  Widget build(BuildContext context) {
    dynamic spellFound;
    dynamic school;
    dynamic classes;
    dynamic subclasses;
    dynamic nameSpell = TextEditingController();
    dynamic lvlSpell = TextEditingController();
    List spells = context.watch<Character_Provide>().currentCharacter.spells;
    List spellSlots =
        context.watch<Character_Provide>().currentCharacter.spell_slots;
    dynamic spellsController = [
      TextEditingController(),
      TextEditingController(),
      TextEditingController(),
      TextEditingController(),
      TextEditingController(),
      TextEditingController(),
      TextEditingController(),
      TextEditingController(),
      TextEditingController(),
      TextEditingController(),
      TextEditingController(),
      TextEditingController(),
      TextEditingController(),
      TextEditingController(),
      TextEditingController(),
      TextEditingController(),
      TextEditingController(),
      TextEditingController(),
    ];
    Future<void> _showMyDialog() async {
      return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Theme.of(context).colorScheme.background,
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text("${spellFound["name"]}",
                      style: Theme.of(context).textTheme.headline1),
                  SizedBox(height: 10),
                  (spellFound["ritual"] == true)
                      ? Text(
                          "${spellFound["level"]}th-level ${school["name"]} (ritual)",
                          style: TextStyle(fontSize: 14))
                      : Text("${spellFound["level"]}th-level ${school["name"]}",
                          style: TextStyle(fontSize: 14)),
                  Row(
                    children: [
                      Text("Casting Time:",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      Text(" ${spellFound["casting_time"]}"),
                    ],
                  ),
                  Row(
                    children: [
                      Text("Range:",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      Text(" ${spellFound["range"]}"),
                    ],
                  ),
                  Row(
                    children: [
                      Text("Components:",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      for (int i = 0; i < spellFound["components"].length; i++)
                        Text(" ${spellFound["components"][i]}"),
                    ],
                  ),
                  Row(
                    children: [
                      Text("Duration:",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      Text(" ${spellFound["duration"]}"),
                    ],
                  ),
                  Divider(
                    thickness: 3,
                    color: Theme.of(context).colorScheme.primaryContainer,
                  ),
                  for (int i = 0; i < spellFound["desc"].length; i++)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 6.0),
                      child: Text("${spellFound["desc"][i]}",
                          style: TextStyle(fontSize: 14)),
                    ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Text("Classes:",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      Text(" ${classes[0]["name"]}"),
                    ],
                  ),
                  (subclasses.length != 0)
                      ? Row(
                          children: [
                            Text("Subclasses:",
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            Text(" ${subclasses[0]["name"]}"),
                          ],
                        )
                      : SizedBox(),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: Text('Ok',
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.primaryContainer)),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }

    Future<void> _showDialogAddSpell() async {
      return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Theme.of(context).colorScheme.secondary,
            title: Text('Add New Spell',
                style: Theme.of(context).textTheme.headline6),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  InputText(
                      label: "",
                      hintText: "Name",
                      controller: nameSpell,
                      color: Theme.of(context).colorScheme.tertiary),
                  InputText(
                      label: "",
                      hintText: "Level",
                      controller: lvlSpell,
                      color: Theme.of(context).colorScheme.tertiary),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: const Text('Ok'),
                onPressed: () {
                  context
                      .read<Character_Provide>()
                      .addSpell(nameSpell.text, int.parse(lvlSpell.text));
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }

    return Container(
      child: Column(
        children: [
          ConstrainedBox(
            constraints: BoxConstraints(maxHeight: 230),
            child: Container(
              color: Theme.of(context).colorScheme.secondary,
              child: Column(children: [
                Container(
                  padding: EdgeInsets.only(top: 30, bottom: 6),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("SPELL SLOTS",
                          style: Theme.of(context).textTheme.headline3),
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.only(
                            top: 8.0, left: 8.0, bottom: 5, right: 8),
                        child: Column(
                          children: [
                            Expanded(
                                child: Text(
                              "LEVEL",
                              style: Theme.of(context).textTheme.headline3,
                            )),
                            Expanded(
                              child: Text("MAX",
                                  style: Theme.of(context).textTheme.headline3),
                            ),
                            Expanded(
                                child: Text("CURRENT",
                                    style:
                                        Theme.of(context).textTheme.headline3))
                          ],
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(7.0),
                          child: GridView.count(
                            scrollDirection: Axis.horizontal,
                            crossAxisCount: 1,
                            mainAxisSpacing: 7,
                            crossAxisSpacing: 7,
                            childAspectRatio: 2,
                            children: List.generate(
                                9,
                                ((index) => Column(
                                      children: [
                                        Text(
                                          "${index + 1}",
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline3,
                                        ),
                                        SizedBox(height: 12),
                                        Expanded(
                                          child: Row(
                                            children: [
                                              Expanded(
                                                child: DataDeIncrementSmaller(
                                                    startingValue:
                                                        spellSlots[index],
                                                    controller:
                                                        spellsController[index],
                                                    index: index),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          child: Row(
                                            children: [
                                              Expanded(
                                                child: DataDeIncrementSmaller(
                                                    startingValue:
                                                        spellSlots[index + 9],
                                                    controller:
                                                        spellsController[
                                                            index + 9],
                                                    index: index + 9),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(height: 14),
                                      ],
                                    ))),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ]),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Expanded(
              child: Padding(
            padding:
                const EdgeInsets.only(top: 3, bottom: 8.0, left: 8.0, right: 8),
            child: Card(
              color: Theme.of(context).colorScheme.background,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 8.0,
                      right: 8.0,
                    ),
                    child: Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.secondary,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Row(
                        children: [
                          Text("LEVEL",
                              style: Theme.of(context).textTheme.headline3),
                          SizedBox(width: 35),
                          Center(
                              child: Text("SPELL NAME",
                                  style: Theme.of(context).textTheme.headline3))
                        ],
                      ),
                    ),
                  ),
                  (spells.length <= 0)
                      ? Container()
                      : Expanded(
                          child: Padding(
                          padding: EdgeInsets.all(8),
                          child: GridView.count(
                            crossAxisCount: 1,
                            mainAxisSpacing: 4,
                            childAspectRatio: 6.0,
                            children: List.generate(
                                spells.length,
                                (index) => Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 4.0),
                                      child: Container(
                                        padding: EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .secondary,
                                          borderRadius:
                                              BorderRadius.circular(30),
                                        ),
                                        child: Row(
                                          children: [
                                            Text("Lvl. ${spells[index].level}"),
                                            Expanded(
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 8.0,
                                                    bottom: 8.0,
                                                    left: 40.0,
                                                    right: 8.0),
                                                child: Text(
                                                    "${spells[index].name}"),
                                              ),
                                            ),
                                            IconButton(
                                                icon: Icon(Icons.search),
                                                onPressed: () async {
                                                  spellFound = await context
                                                      .read<Character_Provide>()
                                                      .findSpell(
                                                          "${spells[index].name}");
                                                  if (spellFound.length == 0) {
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(SnackBar(
                                                      content: Text(
                                                        "The spell could not be found",
                                                        style: TextStyle(
                                                          fontSize: 16,
                                                        ),
                                                        textAlign:
                                                            TextAlign.center,
                                                      ),
                                                    ));
                                                  } else {
                                                    school =
                                                        spellFound["school"];
                                                    classes =
                                                        spellFound["classes"];
                                                    subclasses = spellFound[
                                                        "subclasses"];
                                                    _showMyDialog();
                                                  }
                                                }),
                                            IconButton(
                                                icon: Icon(Icons.delete),
                                                onPressed: () {
                                                  context
                                                      .read<Character_Provide>()
                                                      .deleteSpell(index);
                                                  spells = context
                                                      .read<Character_Provide>()
                                                      .currentCharacter
                                                      .spells;
                                                })
                                          ],
                                        ),
                                      ),
                                    )),
                          ),
                        ))
                ],
              ),
            ),
          )),
          ElevatedButton(
              child: Text("Add a spell"),
              onPressed: () {
                _showDialogAddSpell();
              })
        ],
      ),
    );
  }
}
