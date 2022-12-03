import 'package:character_keeper/items/data_de_increment_medium.dart';
import 'package:character_keeper/providers/character_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class InventoryPage extends StatelessWidget {
  InventoryPage({super.key});

  dynamic searchItem = TextEditingController();
  @override
  Widget build(BuildContext context) {
    dynamic itemAcountController = [];
    dynamic nameItem = TextEditingController();
    dynamic descItem = TextEditingController();
    dynamic quantityItem = TextEditingController();
    int currentIndex = 0;

    List inventory = context.watch<Character_Provide>().displayInventory;
    for (int i = 0; i < inventory.length; i++) {
      itemAcountController.add(TextEditingController());
    }
    Future<void> _showDialogAddItem() async {
      return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Theme.of(context).colorScheme.secondary,
            title: const Text('Adding an Item'),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  TextField(
                      controller: nameItem,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: "Name of the Item",
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 2,
                                color: Theme.of(context)
                                    .colorScheme
                                    .primaryContainer),
                          ))),
                  SizedBox(height: 20),
                  TextField(
                      decoration: InputDecoration(
                          hintText: "Write the description of the Item here",
                          contentPadding: EdgeInsets.all(8.0),
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 2,
                                color: Theme.of(context)
                                    .colorScheme
                                    .primaryContainer),
                          )),
                      maxLines: 9,
                      controller: descItem),
                  SizedBox(height: 8),
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
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 2,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .primaryContainer),
                              )),
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
                child: Text('Cancel',
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.primaryContainer)),
                onPressed: () {
                  nameItem.text = "";
                  descItem.text = "";
                  quantityItem.text = "";
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: Text('Done',
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.primaryContainer)),
                onPressed: () {
                  int n = 0;
                  try {
                    n = int.parse(quantityItem.text);
                  } catch (e) {
                    n = 0;
                  }

                  try {
                    context
                        .read<Character_Provide>()
                        .addItem(nameItem.text, descItem.text, n);
                    context
                        .read<Character_Provide>()
                        .searchItem(searchItem.text);
                    nameItem.text = "";
                    descItem.text = "";
                    quantityItem.text = "";
                    Navigator.of(context).pop();
                  } catch (e) {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text(e.toString())));
                    Navigator.of(context).pop();
                  }
                },
              ),
            ],
          );
        },
      );
    }

    Future<void> _showDialogEditItem() async {
      return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Theme.of(context).colorScheme.secondary,
            title: const Text('Your Item'),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  TextField(
                      controller: nameItem,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: "Name of the Item",
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 2,
                                color: Theme.of(context)
                                    .colorScheme
                                    .primaryContainer),
                          ))),
                  SizedBox(height: 20),
                  TextField(
                      decoration: InputDecoration(
                          hintText: "Write the description of the Item here",
                          contentPadding: EdgeInsets.all(8.0),
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 2,
                                color: Theme.of(context)
                                    .colorScheme
                                    .primaryContainer),
                          )),
                      maxLines: 9,
                      controller: descItem),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: Text('Cancel',
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.primaryContainer)),
                onPressed: () {
                  nameItem.text = "";
                  descItem.text = "";
                  quantityItem.text = "";
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: Text('Edit',
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.primaryContainer)),
                onPressed: () {
                  int n;
                  try {
                    n = int.parse(quantityItem.text);
                  } catch (e) {
                    n = 0;
                  }

                  try {
                    context.read<Character_Provide>().updateItem(
                        currentIndex, nameItem.text, descItem.text, n);
                    context
                        .read<Character_Provide>()
                        .searchItem(searchItem.text);
                    nameItem.text = "";
                    descItem.text = "";
                    quantityItem.text = "";
                    Navigator.of(context).pop();
                  } catch (e) {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text(e.toString())));
                    Navigator.of(context).pop();
                  }
                },
              ),
            ],
          );
        },
      );
    }

    Future<void> _showDialogNoteWithInitialValues(String initialName,
        String initialDescription, int initialQuantity, int index) async {
      nameItem.text = initialName;
      descItem.text = initialDescription;
      quantityItem.text = initialQuantity.toString();
      currentIndex = index;

      await _showDialogEditItem();
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
                                child: Text("ITEM AMOUNT, NAME AND DESCRIPTION",
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
                        context.read<Character_Provide>().searchItem(value);
                        searchItem.text = value;
                      }),
                      controller: searchItem,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(
                            top: 10.0, bottom: 10.0, right: 10.0, left: 18.0),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(27)),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: BorderSide(
                              width: 2,
                              color: Theme.of(context)
                                  .colorScheme
                                  .primaryContainer),
                        ),
                        hintText: "Search for an item",
                      ),
                    ),
                  ),
                  SizedBox(height: 8),
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
                                (index) => Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 8.0),
                                      child: Container(
                                        padding: EdgeInsets.all(9),
                                        decoration: BoxDecoration(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .secondary,
                                          borderRadius:
                                              BorderRadius.circular(50),
                                        ),
                                        child: Row(
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  SizedBox(height: 13),
                                                  DataDeIncrementMedium(
                                                      startingValue:
                                                          inventory[index]
                                                              .amount,
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
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
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
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                          )),
                                                      Align(
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        child: Text(
                                                          "${inventory[index].description}",
                                                          maxLines: 3,
                                                          textAlign:
                                                              TextAlign.left,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                onTap: () {
                                                  _showDialogNoteWithInitialValues(
                                                      inventory[index].name,
                                                      inventory[index]
                                                          .description,
                                                      inventory[index].amount,
                                                      index);
                                                },
                                              ),
                                            ),
                                            IconButton(
                                                icon: Icon(Icons.delete),
                                                splashRadius: 1,
                                                onPressed: () async {
                                                  try {
                                                    await context
                                                        .read<
                                                            Character_Provide>()
                                                        .deleteItem(index);
                                                    context
                                                        .read<
                                                            Character_Provide>()
                                                        .searchItem(
                                                            searchItem.text);
                                                  } catch (e) {
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(SnackBar(
                                                            content: Text(
                                                                e.toString())));
                                                    Navigator.of(context).pop();
                                                  }
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
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).colorScheme.primary,
                      ),
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
