import 'package:flutter/material.dart';

class SquareData extends StatelessWidget {
  final int content;
  final String name_content;
  const SquareData({
    Key? key,
    required this.content,
    required this.name_content,
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
            Text("+${content}", style: TextStyle(fontSize: 21)),
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
