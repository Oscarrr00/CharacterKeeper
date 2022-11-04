import 'dart:convert';
import 'package:http/http.dart' as http;

class HttpHandler {
  final String url = "https://www.dnd5eapi.co/api/spells/";

  HttpHandler._internal();
  static final HttpHandler _httpHandler = HttpHandler._internal();

  factory HttpHandler() {
    return _httpHandler;
  }

  Future<Map<String, dynamic>> findSpell(String nameSpell) async {
    var urlSpell = url + nameSpell;
    var requestStatus = await http.get(Uri.parse(urlSpell));

    print(requestStatus.body);

    if (requestStatus.statusCode == 200) {
      Map<String, dynamic> spellJson = jsonDecode(requestStatus.body);

      if (spellJson == null) {
        throw Exception("The API couldn't find the spell");
      }

      return spellJson;
    }

    throw Exception("Something went wrong");
  }
}
