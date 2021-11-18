import 'dart:async';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class BearerToken {
  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();

    if (!prefs.containsKey("userData")) {
      return null;
    }

    final extractedData = jsonDecode(prefs.getString("userData")!);
    final expiryDate = DateTime.parse(extractedData['expiryDate']);
    final token = extractedData['token'];

    if (token != null && expiryDate.isAfter(DateTime.now())) {
      return token;
    }
    
    return null;
  }
}
