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
            color: Theme.of(context).colorScheme.secondary,
            borderRadius: BorderRadius.circular(15)),
        child: Center(
            child: Text("${content}",
                style:
                    TextStyle(color: Theme.of(context).colorScheme.tertiary))));
  }
}
