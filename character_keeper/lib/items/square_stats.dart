import 'package:character_keeper/providers/character_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SquareData extends StatelessWidget {
  final String name_content;
  final TextEditingController controller;
  const SquareData({
    Key? key,
    required this.name_content,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("+", style: TextStyle(fontSize: 21)),
            SizedBox(
              height: MediaQuery.of(context).size.height / 13,
              width: 35,
              child: TextFormField(
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: MediaQuery.of(context).size.height / 31),
                decoration: InputDecoration(
                  border: InputBorder.none,
                ),
                controller: controller,
                readOnly: true,
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
        Text("${name_content}", style: Theme.of(context).textTheme.headline3),
      ],
    );
  }
}
