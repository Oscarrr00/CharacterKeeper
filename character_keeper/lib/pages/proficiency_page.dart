import 'package:flutter/material.dart';

class ProficiencyPage extends StatelessWidget {
  const ProficiencyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
          child: Padding(
        padding: EdgeInsets.all(8),
        child: Column(
          children: [
            Center(
                child: Text(
              "Skill Proficiencies",
              style: Theme.of(context).textTheme.headline6,
            )),
            Expanded(
                child: Card(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Proficiency Bonus",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CircleAvatar(
                          backgroundColor:
                              Theme.of(context).colorScheme.primary,
                          child: Text(
                            "+2",
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
                    color: Theme.of(context).colorScheme.secondary,
                    child: Row(
                      children: [
                        Expanded(
                            child: Center(
                                child: Text("Skill Proficiencies",
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
                      childAspectRatio: 7.0,
                      children: List.generate(
                          18,
                          (index) => Container(
                                padding: EdgeInsets.all(4),
                                color: index % 2 == 1 ? Colors.grey[350] : null,
                                child: Row(
                                  children: [
                                    Expanded(
                                        child: Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: CircleAvatar(
                                            backgroundColor: Theme.of(context)
                                                .colorScheme
                                                .secondary,
                                            radius: 10,
                                          ),
                                        ),
                                        Expanded(child: Text("Athletics")),
                                        Text("STR",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold))
                                      ],
                                    )),
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
                      child: Text("Edit Proficiencies"), onPressed: () {}),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}


