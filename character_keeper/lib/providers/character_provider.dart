import 'package:character_keeper/http_handler.dart';
import 'package:flutter/material.dart';

class Character_Provide with ChangeNotifier {
  var httpHandler = new HttpHandler();
  Future<Map<String, dynamic>> findSpell(String nameSpell) async {
    try {
      var spell = await httpHandler.findSpell(nameSpell);
      return spell;
    } catch (e) {
      return {};
    }
  }
}
