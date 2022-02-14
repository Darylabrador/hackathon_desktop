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

      if (response.statusCode != 200) {
        throw HttpException(jsonDecode(response.body)['message']);
      }

      return responseData["data"];
    } catch (e) {
      throw HttpException(e.toString());
    }
  }

  Future<Map<String, dynamic>> updateAccount(
    String email,
    String surname,
    String firstname,
    int gender,
    int age,
  ) async {
    final url = Uri.parse(
      "${ConstantVariables.startingURL}/account/informations",
    );
    try {
      final response = await http.post(
        url,
        body: jsonEncode({
          'email': email,
          'surname': surname,
          'firstname': firstname,
          'gender': gender,
          'age': age,
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

  Future<Map<String, dynamic>> deleteAccount(
    String password,
    String passwordConfirm,
  ) async {
    final url = Uri.parse(
      "${ConstantVariables.startingURL}/account/delete",
    );
    try {
      final response = await http.post(
        url,
        body: jsonEncode({
          'password': password,
          'passwordConfirm': passwordConfirm,
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
