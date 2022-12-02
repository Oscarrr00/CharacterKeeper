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
            backgroundColor: Theme.of(context).colorScheme.secondary,
            title: const Text('Adding an ability'),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  TextField(
                      controller: abilityName,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: "Ability name",
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 2,
                                color: Theme.of(context)
                                    .colorScheme
                                    .primaryContainer),
                          ))),
                  SizedBox(height: 20),
                  Expanded(
                    child: TextField(
                        decoration: InputDecoration(
                            hintText: "Ability description",
                            contentPadding: EdgeInsets.all(8.0),
                            border: OutlineInputBorder(),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 2,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .primaryContainer),
                            )),
                        maxLines: 10,
                        controller: abilityDescription),
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: Text('Cancel',
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.primaryContainer)),
                onPressed: () {
                  abilityName.text = "";
                  abilityDescription.text = "";
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: Text('Done',
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.primaryContainer)),
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
            backgroundColor: Theme.of(context).colorScheme.secondary,
            title: const Text('Your ability'),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  TextField(
                      controller: abilityName,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: "Ability name",
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 2,
                                color: Theme.of(context)
                                    .colorScheme
                                    .primaryContainer),
                          ))),
                  SizedBox(height: 20),
                  Expanded(
                    child: TextField(
                        decoration: InputDecoration(
                            hintText: "Ability description",
                            contentPadding: EdgeInsets.all(8.0),
                            border: OutlineInputBorder(),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 2,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .primaryContainer),
                            )),
                        maxLines: 10,
                        controller: abilityDescription),
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: Text('Cancel',
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.primaryContainer)),
                onPressed: () {
                  abilityName.text = "";
                  abilityDescription.text = "";
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: Text('Edit',
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.primaryContainer)),
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
            SizedBox(height: 20),
            Expanded(
                child: Container(
              child: Column(
                children: [
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
                                child: Text("ABILITY NAME AND DESCRIPTION",
                                    style:
                                        Theme.of(context).textTheme.headline3)))
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
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                            borderSide: BorderSide(
                                width: 2,
                                color: Theme.of(context)
                                    .colorScheme
                                    .primaryContainer),
                          )),
                    ),
                  ),
                  SizedBox(height: 10),
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
                                (index) => Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 8.0),
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
                                            Expanded(
                                              child: InkWell(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Align(
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          child: Text(
                                                            abilities[index]
                                                                .name,
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                            maxLines: 1,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                          )),
                                                      Align(
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        child: Text(
                                                          abilities[index]
                                                              .description,
                                                          maxLines: 3,
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
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).colorScheme.primary,
                      ),
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
