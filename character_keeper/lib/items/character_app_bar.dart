import 'package:flutter/material.dart';

class CharacterAppBar extends StatelessWidget {
  const CharacterAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return 
    AppBar(
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
      );
  }
}