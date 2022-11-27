import 'package:character_keeper/providers/character_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SquareDataEdit extends StatelessWidget {
  final String name_content;
  final TextEditingController controller;
  const SquareDataEdit({
    Key? key,
    required this.name_content,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 90,
        height: 90,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("+", style: TextStyle(fontSize: 21)),
                SizedBox(
                  height: 38,
                  width: 30,
                  child: TextFormField(
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 21),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                    ),
                    controller: controller,
                    keyboardType: TextInputType.numberWithOptions(
                      decimal: false,
                    ),
                    onFieldSubmitted: (value) {
                      int num = int.parse(value);
                      context.read<Character_Provide>().updateSpeed(num);
                    },
                  ),
                ),
              ],
            ),
            Text("${name_content}", style: TextStyle(fontSize: 17)),
          ],
        ),
        decoration: ShapeDecoration(
            shape: BeveledRectangleBorder(
                side: BorderSide(
          color: Colors.black,
        ))));
  }
}
