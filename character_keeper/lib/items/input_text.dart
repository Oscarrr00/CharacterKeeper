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
          Text("${label}", style: Theme.of(context).textTheme.headline6),
          TextField(
              controller: controller,
              decoration: InputDecoration(
                  filled: true,
                  fillColor: Theme.of(context).colorScheme.secondary,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(
                        width: 2,
                        color: Theme.of(context).colorScheme.tertiary),
                  ),
                  hintText: "${hintText}",
                  hintStyle:
                      TextStyle(color: Theme.of(context).colorScheme.tertiary),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(
                        width: 2,
                        color: Theme.of(context).colorScheme.primaryContainer),
                  ))),
        ],
      ),
    );
  }
}
