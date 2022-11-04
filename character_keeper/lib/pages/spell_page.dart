import 'package:character_keeper/items/data_de_incremente_smaller.dart';
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
    dynamic spellsController = [
      TextEditingController(),
      TextEditingController(),
      TextEditingController(),
      TextEditingController(),
      TextEditingController(),
      TextEditingController(),
      TextEditingController(),
      TextEditingController(),
      TextEditingController()
    ];
    Future<void> _showMyDialog() async {
      return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text("${spellFound["name"]}",
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.primary)),
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
                    color: Theme.of(context).colorScheme.primary,
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
                child: const Text('Ok'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }

    return Container(
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Column(
          children: [
            Center(
                child: Text(
              "Spells",
              style: Theme.of(context).textTheme.headline6,
            )),
            ConstrainedBox(
              constraints: BoxConstraints(maxHeight: 150),
              child: Card(
                child: Column(children: [
                  Container(
                    color: Theme.of(context).colorScheme.secondary,
                    padding: EdgeInsets.only(top: 6, bottom: 6),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Spell Slots",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(8.0),
                          color: Theme.of(context).colorScheme.secondary,
                          child: Column(
                            children: [
                              Expanded(
                                  child: Text(
                                "Level",
                                style: TextStyle(color: Colors.white),
                              )),
                              Expanded(
                                child: Text("Max",
                                    style: TextStyle(color: Colors.white)),
                              ),
                              Expanded(
                                  child: Text("Current",
                                      style: TextStyle(color: Colors.white)))
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
                              childAspectRatio: 1.5,
                              children: List.generate(
                                  9,
                                  ((index) => Column(
                                        children: [
                                          Expanded(
                                              child: Text(
                                            "${index + 1}",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          )),
                                          Expanded(
                                            child: Row(
                                              children: [
                                                Expanded(
                                                  child: DataDeIncrementSmaller(
                                                      controller:
                                                          spellsController[
                                                              index]),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Expanded(
                                            child: Row(
                                              children: [
                                                Expanded(
                                                  child: DataDeIncrementSmaller(
                                                      controller:
                                                          spellsController[
                                                              index]),
                                                ),
                                              ],
                                            ),
                                          ),
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
                child: Card(
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(8),
                    color: Theme.of(context).colorScheme.secondary,
                    child: Row(
                      children: [
                        Text("Level",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                        Expanded(
                            child: Center(
                                child: Text("Spell name",
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
                      childAspectRatio: 6.0,
                      children: List.generate(
                          15,
                          (index) => Container(
                                padding: EdgeInsets.all(4),
                                color: index % 2 == 1 ? Colors.grey[350] : null,
                                child: Row(
                                  children: [
                                    Text("Lvl. ${index + 1}"),
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                            "Mordenkainen's Magnificient Mansion"),
                                      ),
                                    ),
                                    IconButton(
                                        icon: Icon(Icons.search),
                                        onPressed: () async {
                                          spellFound = await context
                                              .read<Character_Provide>()
                                              .findSpell("find-familiar");
                                          if (spellFound.length == 0) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(SnackBar(
                                              content: Text(
                                                "El hechizo no fue encontrado",
                                                style: TextStyle(
                                                  fontSize: 16,
                                                ),
                                                textAlign: TextAlign.center,
                                              ),
                                            ));
                                          } else {
                                            school = spellFound["school"];
                                            classes = spellFound["classes"];
                                            subclasses =
                                                spellFound["subclasses"];
                                            _showMyDialog();
                                          }
                                        }),
                                    IconButton(
                                        icon: Icon(Icons.delete),
                                        onPressed: () {})
                                  ],
                                ),
                              )),
                    ),
                  ))
                ],
              ),
            )),
            ElevatedButton(child: Text("Add a spell"), onPressed: () {})
          ],
        ),
      ),
    );
  }
}