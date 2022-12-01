import 'package:character_keeper/providers/character_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AbilityPage extends StatelessWidget {
  AbilityPage({super.key});

  dynamic abilityName = TextEditingController();
  dynamic abilityDescription = TextEditingController();
  dynamic searchAbility = TextEditingController();
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    List abilities = context.watch<Character_Provide>().displayAbilities;

    Future<void> _showDialogAddAbility() async {
      return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Adding an ability'),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  TextField(
                      style: TextStyle(color: Colors.black),
                      controller: abilityName,
                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 1, color: Colors.black),
                          ),
                          hintText: "Ability name",
                          hintStyle: TextStyle(color: Colors.black),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 2, color: Colors.black),
                          ))),
                  SizedBox(height: 20),
                  Expanded(
                    child: TextField(
                        decoration: InputDecoration(
                          hintText: "Ability description",
                          contentPadding: EdgeInsets.all(8.0),
                          border: OutlineInputBorder(),
                        ),
                        maxLines: 10,
                        controller: abilityDescription),
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('Cancel'),
                onPressed: () {
                  abilityName.text = "";
                  abilityDescription.text = "";
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: const Text('Done'),
                onPressed: () {
                  context
                      .read<Character_Provide>()
                      .addAbility(abilityName.text, abilityDescription.text);
                  context
                      .read<Character_Provide>()
                      .searchNote(searchAbility.text);
                  abilityName.text = "";
                  abilityDescription.text = "";
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }

    Future<void> _showDialogEditAbility() async {
      return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Your ability'),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  TextField(
                      style: TextStyle(color: Colors.black),
                      controller: abilityName,
                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 1, color: Colors.black),
                          ),
                          hintText: "Ability name",
                          hintStyle: TextStyle(color: Colors.black),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 2, color: Colors.black),
                          ))),
                  SizedBox(height: 20),
                  Expanded(
                    child: TextField(
                        decoration: InputDecoration(
                          hintText: "Ability description",
                          contentPadding: EdgeInsets.all(8.0),
                          border: OutlineInputBorder(),
                        ),
                        maxLines: 10,
                        controller: abilityDescription),
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('Cancel'),
                onPressed: () {
                  abilityName.text = "";
                  abilityDescription.text = "";
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: const Text('Edit'),
                onPressed: () {
                  context.read<Character_Provide>().updateAbility(
                      currentIndex, abilityName.text, abilityDescription.text);
                  context
                      .read<Character_Provide>()
                      .searchNote(searchAbility.text);
                  abilityName.text = "";
                  abilityDescription.text = "";
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }

    Future<void> _showDialogNoteWithInitialValues(
        String initialName, String initialDescription, int index) async {
      abilityName.text = initialName;
      abilityDescription.text = initialDescription;
      currentIndex = index;

      await _showDialogEditAbility();
    }

    return Container(
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Column(
          children: [
            Center(
                child: Text(
              "Abilities",
              style: Theme.of(context).textTheme.headline6,
            )),
            Expanded(
                child: Card(
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(8),
                    color: Theme.of(context).colorScheme.secondary,
                    child: Row(
                      children: [
                        Expanded(
                            child: Center(
                                child: Text("Ability Name and Description",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold))))
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  SizedBox(
                    height: 40,
                    child: TextField(
                      onSubmitted: ((value) {
                        context.read<Character_Provide>().searchAbility(value);
                        searchAbility.text = value;
                      }),
                      controller: searchAbility,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(
                            top: 10.0, bottom: 10.0, right: 10.0, left: 18.0),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25)),
                        hintText: "Search for an Ability",
                      ),
                    ),
                  ),
                  Expanded(
                      child: Padding(
                    padding: EdgeInsets.all(8),
                    child: abilities.length <= 0
                        ? Container()
                        : GridView.count(
                            crossAxisCount: 1,
                            mainAxisSpacing: 4,
                            childAspectRatio: 3.0,
                            children: List.generate(
                                abilities.length,
                                (index) => Container(
                                      padding: EdgeInsets.all(4),
                                      color: index % 2 == 1
                                          ? Colors.grey[350]
                                          : null,
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: InkWell(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Column(
                                                  children: [
                                                    Align(
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        child: Text(
                                                          abilities[index].name,
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                          maxLines: 1,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        )),
                                                    Align(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: Text(
                                                        abilities[index]
                                                            .description,
                                                        maxLines: 4,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              onTap: () {
                                                _showDialogNoteWithInitialValues(
                                                    abilities[index].name,
                                                    abilities[index]
                                                        .description,
                                                    index);
                                              },
                                            ),
                                          ),
                                          IconButton(
                                              icon: Icon(Icons.delete),
                                              splashColor: Colors.red[200],
                                              onPressed: () async {
                                                await context
                                                    .read<Character_Provide>()
                                                    .deleteAbility(index);
                                                context
                                                    .read<Character_Provide>()
                                                    .searchNote(
                                                        searchAbility.text);
                                              })
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
                      child: Text("Add an ability"),
                      onPressed: () {
                        _showDialogAddAbility();
                      }),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
