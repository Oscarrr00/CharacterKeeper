import 'package:flutter/material.dart';

class ShowData extends StatelessWidget {
  final String content;
  const ShowData({
    Key? key,
    required this.content,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 250,
        decoration: BoxDecoration(
            color: Colors.grey, border: Border.all(color: Colors.black)),
        child: Center(child: Text("${content}")));
  }
}
