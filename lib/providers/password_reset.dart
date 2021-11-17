import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';

import '../models/http_exception.dart';
import '../utils/constant_variables.dart';

class PasswordReset with ChangeNotifier {
  final String? authToken;
  PasswordReset({this.authToken});

  Future<Map<String, dynamic>> loggedOutResetingAsk(String email) async {
    final url = Uri.parse("${ConstantVariables.startingURL}/reset/ask");
    try {
      final response = await http.post(
        url,
        body: jsonEncode({'email': email, 'isWeb': false}),
        headers: {
          'Authorization': "Bearer $authToken",
          "Content-Type": "application/json"
        },
      );
      final responseData = jsonDecode(response.body);
      return responseData;
    } catch (e) {
      throw HttpException("Veuillez réessayer ultérieurement");
    }
  }

  Future<Map<String, dynamic>> loggedOutResetingPassword(
      String newPassword, String newPasswordConfirm, String? resetToken) async {
    final url = Uri.parse("${ConstantVariables.startingURL}/reset/password");
    try {
      final response = await http.post(
        url,
        body: jsonEncode({
          'newPassword': newPassword,
          'newPasswordConfirm': newPasswordConfirm,
          'resetToken': resetToken,
        }),
        headers: {
          'Authorization': "Bearer $authToken",
          "Content-Type": "application/json"
        },
      );
      final responseData = jsonDecode(response.body);
      return responseData;
    } catch (e) {
      throw HttpException("Veuillez réessayer ultérieurement");
    }
  }
}
