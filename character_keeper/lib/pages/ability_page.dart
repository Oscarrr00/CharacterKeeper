import 'package:flutter/material.dart';

class AbilityPage extends StatelessWidget {
  const AbilityPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(),
            Column(
              children: [
                Text("My character #1"),
                Text(
                  "Lvl 5 Human Bard",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w300),
                )
              ],
            ),
            SizedBox(width: 40),
          ],
        ),
      ),
      body: Container(
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
                    child: GridView.count(
                      crossAxisCount: 1,
                      mainAxisSpacing: 4,
                      childAspectRatio: 3.0,
                      children: List.generate(
                          15,
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
                                                    "Darkvision",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold),
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  )),
                                              Text(
                                                "Accustomed to life underground, you have superior vision in dark and dim conditions. You can see in dim light within 60 feet of you as if it were bright light, and in darkness as if it were dim light. You can't discern color in darkness, only shades of gray.",
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
                                        onPressed: () {})
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
      )),
    );
  }
}
