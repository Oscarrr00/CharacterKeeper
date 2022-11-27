import 'package:character_keeper/items/data_de_increment_medium.dart';
import 'package:character_keeper/providers/character_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class InventoryPage extends StatelessWidget {
  const InventoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    dynamic itemAcountController = [];
    dynamic nameItem = TextEditingController();
    dynamic descItem = TextEditingController();
    dynamic quantityItem = TextEditingController();
    List inventory =
        context.watch<Character_Provide>().currentCharacter.inventory;
    for (int i = 0; i < inventory.length; i++) {
      itemAcountController.add(TextEditingController());
    }
    Future<void> _showDialogAddItem() async {
      return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Adding an Item'),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  TextField(
                      style: TextStyle(color: Colors.black),
                      controller: nameItem,
                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 1, color: Colors.black),
                          ),
                          hintText: "Name of the Item",
                          hintStyle: TextStyle(color: Colors.black),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 2, color: Colors.black),
                          ))),
                  SizedBox(height: 20),
                  TextField(
                      decoration: InputDecoration(
                        hintText: "Write the description of the Item here",
                        contentPadding: EdgeInsets.all(8.0),
                        border: OutlineInputBorder(),
                      ),
                      maxLines: 9,
                      controller: descItem),
                  Row(
                    children: [
                      Text("Quantity: "),
                      SizedBox(
                        height: 25,
                        width: 30,
                        child: TextFormField(
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(8.0),
                            border: OutlineInputBorder(),
                          ),
                          controller: quantityItem,
                          keyboardType: TextInputType.numberWithOptions(
                            decimal: false,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('Cancel'),
                onPressed: () {
                  nameItem.text = "";
                  descItem.text = "";
                  quantityItem.text = "";
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: const Text('Done'),
                onPressed: () {
                  context.read<Character_Provide>().addItem(nameItem.text,
                      descItem.text, int.parse(quantityItem.text));
                  nameItem.text = "";
                  descItem.text = "";
                  quantityItem.text = "";
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
              "Inventory",
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
                                child: Text("Item Amount, Name and Description",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold))))
                      ],
                    ),
                  ),
                  (inventory.length <= 0)
                      ? Container()
                      : Expanded(
                          child: Padding(
                          padding: EdgeInsets.all(8),
                          child: GridView.count(
                            crossAxisCount: 1,
                            mainAxisSpacing: 4,
                            childAspectRatio: 3.0,
                            children: List.generate(
                                inventory.length,
                                (index) => Container(
                                      padding: EdgeInsets.all(4),
                                      color: index % 2 == 1
                                          ? Colors.grey[350]
                                          : null,
                                      child: Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                SizedBox(),
                                                DataDeIncrementMedium(
                                                    startingValue:
                                                        inventory[index].amount,
                                                    controller:
                                                        itemAcountController[
                                                            index],
                                                    index: index),
                                                SizedBox(height: 20),
                                              ],
                                            ),
                                          ),
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
                                                          "${inventory[index].name}",
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
                                                        "${inventory[index].description}",
                                                        maxLines: 4,
                                                        textAlign:
                                                            TextAlign.left,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
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
                                                context
                                                    .read<Character_Provide>()
                                                    .deleteItem(index);
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
                      child: Text("Add an inventory entry"),
                      onPressed: () {
                        _showDialogAddItem();
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
