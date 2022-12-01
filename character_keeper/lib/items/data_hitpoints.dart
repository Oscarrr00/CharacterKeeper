import 'package:character_keeper/items/data_de_increment.dart';
import 'package:flutter/material.dart';

class DataHitpoints extends StatelessWidget {
  final TextEditingController controller;
  final String first_title;
  int startingValue;
  final String nameValue;
  DataHitpoints({
    Key? key,
    required this.startingValue,
    required this.controller,
    required this.first_title,
    required this.nameValue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.text = startingValue.toString();
    return Container(
      width: MediaQuery.of(context).size.width / 4,
      height: MediaQuery.of(context).size.height / 8,
      child: Column(
        children: [
          DataDeIncrement(controller: controller, nameValue: nameValue),
          SizedBox(height: 7),
          Text("${first_title.toUpperCase()}",
              style: Theme.of(context).textTheme.headline3),
          Text("HIT POINTS", style: Theme.of(context).textTheme.headline3),
        ],
      ),
    );
  }
}
