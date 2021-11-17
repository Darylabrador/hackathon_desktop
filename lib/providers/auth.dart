import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

import '../models/http_exception.dart';
import '../utils/constant_variables.dart';

class Auth with ChangeNotifier {
  String? _token;
  DateTime? _expiryDate;
  Timer? _authTimer;

  bool get isAuth {
    // ignore: unnecessary_null_comparison
    return token != null;
  }

  String? get token {
    if (_token != null &&
        _expiryDate != null &&
        _expiryDate!.isAfter(DateTime.now())) {
      return _token;
    }
    return null;
  }

  Future<void> _setSharedPreference(String? token, DateTime? expiryDate) async {
    final prefs = await SharedPreferences.getInstance();
    final userData = jsonEncode({
      'token': token,
      'expiryDate': expiryDate!.toIso8601String(),
    });
    await prefs.setString('userData', userData);
  }

  Future<Map<String, dynamic>> login(String email, String password) async {
    final url = Uri.parse("${ConstantVariables.startingURL}/login");
    try {
      final response = await http.post(
        url,
        body: {
          'email': email,
          'password': password,
        },
      );
      final responseData = json.decode(response.body);
      if (responseData["role"] == "laposte" ||
          responseData["role"] == "admin") {
        if (responseData["success"]) {
          _token = responseData["token"];
          _expiryDate = JwtDecoder.getExpirationDate(responseData["token"]);
          notifyListeners();
          _autoLogout();
          _setSharedPreference(_token, _expiryDate);
        }
        return responseData;
      } else {
        return {
          'success': false,
          'message': "Vous n'êtes pas autorisé à vous connecter"
        };
      }
    } catch (e) {
      throw HttpException("Veuillez réessayer ultérieurement");
    }
  }

  Future<bool> tryAutoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey("userData")) {
      return false;
    }

    final extractedData = prefs.getString("userData") as Map<String, dynamic>;
    final expiryDate = DateTime.parse(extractedData['expiryDate']);
    if (expiryDate.isBefore(DateTime.now())) {
      return false;
    }

    _token = extractedData["token"];
    _expiryDate = extractedData['expiryDate'];
    notifyListeners();
    _autoLogout();
    return true;
  }

  Future<void> logout() async {
    final url = Uri.parse("${ConstantVariables.startingURL}/logout");
    await http.get(url, headers: {'Authorization': "Bearer $_token"});
    _token = null;
    notifyListeners();
  }

  void _autoLogout() {
    if (_authTimer != null) _authTimer!.cancel();
    final timeToExpired = _expiryDate!.difference(DateTime.now()).inSeconds;
    _authTimer = Timer(Duration(seconds: timeToExpired), logout);
  }
}
