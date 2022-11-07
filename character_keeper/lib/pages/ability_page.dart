import 'package:character_keeper/providers/character_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AbilityPage extends StatelessWidget {
  const AbilityPage({super.key});

  @override
  Widget build(BuildContext context) {

    List abilities = context.watch<Character_Provide>().currentCharacter.abilities;

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
                  Expanded(
                      child: Padding(
                    padding: EdgeInsets.all(8),
                    child: abilities.length <= 0 ? Container() :                    
                    GridView.count(
                      crossAxisCount: 1,
                      mainAxisSpacing: 4,
                      childAspectRatio: 3.0,
                      children: List.generate(
                          abilities.length,
                          (index) => Container(
                                padding: EdgeInsets.all(4),
                                color: index % 2 == 1 ? Colors.grey[350] : null,
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: InkWell(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            children: [
                                              Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text(
                                                    abilities[index].name,
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold),
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  )),
                                              Text(
                                                abilities[index].description,
                                                maxLines: 4,
                                                overflow: TextOverflow.ellipsis,
                                              )
                                            ],
                                          ),
                                        ),
                                        onTap: () {},
                                      ),
                                    ),
                                    IconButton(
                                        icon: Icon(Icons.delete),
                                        splashColor: Colors.red[200],
                                        onPressed: () {
                                          context.read<Character_Provide>().deleteAbility(index);
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
                      child: Text("Add an ability"), onPressed: () {}),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
