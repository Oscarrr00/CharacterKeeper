import 'package:flutter/material.dart';

class InputText extends StatelessWidget {
  final String label;
  final String hintText;
  final TextEditingController controller;
  final Color color;
  const InputText({
    Key? key,
    required this.label,
    required this.hintText,
    required this.controller,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 30.0, right: 30.0, left: 30.0),
      child: Column(
        children: [
          Text("${label}", style: TextStyle(fontSize: 19, color: color)),
          TextField(
              style: TextStyle(color: color),
              controller: controller,
              decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 2, color: color),
                  ),
                  hintText: "${hintText}",
                  hintStyle: TextStyle(color: color),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 2, color: color),
                  ))),
        ],
      ),
    );
  }
}
