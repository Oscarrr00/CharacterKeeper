import 'package:character_keeper/items/data_de_increment.dart';
import 'package:flutter/material.dart';

class DataHitpoints extends StatelessWidget {
  final TextEditingController controller;
  final String first_title;
  DataHitpoints({
    Key? key,
    required this.controller,
    required this.first_title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.height / 7.15,
        height: 84,
        child: Column(
          children: [
            Text("${first_title}", style: TextStyle(fontSize: 14)),
            Text("Hitpoints", style: TextStyle(fontSize: 14)),
            SizedBox(height: 3),
            DataDeIncrement(controller: controller)
          ],
        ),
        decoration: ShapeDecoration(
            shape: BeveledRectangleBorder(
                side: BorderSide(
          color: Colors.black,
        ))));
  }
}
