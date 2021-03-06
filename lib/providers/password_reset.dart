import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';

import '../models/http_exception.dart';
import '../utils/constant_variables.dart';

class PasswordReset with ChangeNotifier {
  final String? authToken;
  PasswordReset({this.authToken});

  Future<Map<String, dynamic>> loggedOutResetingAsk(
    String email,
  ) async {
    final url = Uri.parse(
      "${ConstantVariables.startingURL}/reset/ask",
    );
    try {
      final response = await http.post(
        url,
        body: jsonEncode({'email': email, 'isWeb': false}),
        headers: {"Content-Type": "application/json"},
      );
      final responseData = jsonDecode(response.body);

      if (response.statusCode != 200) {
        throw HttpException(jsonDecode(response.body)['message']);
      }

      return responseData;
    } catch (e) {
      throw HttpException(e.toString());
    }
  }

  Future<Map<String, dynamic>> loggedOutResetingPassword(
    String resetToken,
    String newPassword,
    String newPasswordConfirm,
  ) async {
    final url = Uri.parse(
      "${ConstantVariables.startingURL}/reset/password",
    );
    try {
      final response = await http.post(
        url,
        body: jsonEncode({
          'newPassword': newPassword,
          'newPasswordConfirm': newPasswordConfirm,
          'resetToken': resetToken,
        }),
        headers: {"Content-Type": "application/json"},
      );
      final responseData = jsonDecode(response.body);

      if (response.statusCode != 200) {
        throw HttpException(jsonDecode(response.body)['message']);
      }

      return responseData;
    } catch (e) {
      throw HttpException(e.toString());
    }
  }

  Future<Map<String, dynamic>> loggedInResetingPassword(
    String oldPass,
    String newPass,
    String newPassConfirm,
  ) async {
    final url = Uri.parse(
      "${ConstantVariables.startingURL}/account/password",
    );
    try {
      final response = await http.post(
        url,
        body: jsonEncode({
          'oldPassword': oldPass,
          'password': newPass,
          'passwordConfirm': newPassConfirm,
        }),
        headers: {
          "Authorization": "Bearer $authToken",
          "Content-Type": "application/json"
        },
      );
      final responseData = jsonDecode(response.body);

      if (response.statusCode != 200) {
        throw HttpException(jsonDecode(response.body)['message']);
      }

      return responseData;
    } catch (e) {
      throw HttpException(e.toString());
    }
  }
}
