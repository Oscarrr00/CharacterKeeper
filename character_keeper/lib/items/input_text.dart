import 'package:flutter/material.dart';

class InputText extends StatelessWidget {
  final String label;
  final String hintText;
  final TextEditingController controller;
  const InputText({
    Key? key,
    required this.label,
    required this.hintText,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 30.0, right: 30.0, left: 30.0),
      child: Column(
        children: [
          Text("${label}", style: TextStyle(fontSize: 19)),
          TextField(
              controller: controller,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "${hintText}",
              )),
        ],
      ),
    );
  }
}
