import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';

import '../models/http_exception.dart';
import '../utils/constant_variables.dart';

class AccountSetting with ChangeNotifier {
  final String? authToken;
  AccountSetting({this.authToken});

  Future<Map<String, dynamic>> getAccountInformations() async {
    final url = Uri.parse("${ConstantVariables.startingURL}/informations");
    try {
      final response = await http.get(url, headers: {
        "Authorization": "Bearer $authToken",
        "Content-Type": "application/json"
      });
      final responseData = json.decode(response.body);
      return responseData["data"];
    } catch (e) {
      throw HttpException("Veuillez réessayer ultérieurement");
    }
  }
}
