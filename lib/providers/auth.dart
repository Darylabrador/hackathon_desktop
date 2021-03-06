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
  String? _identity;
  DateTime? _expiryDate;
  Timer? _authTimer;

  String? get identity {
    if (_identity != null) return _identity;
    return "";
  }

  bool get isAuth {
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

  Future<void> _setSharedPreference(
      String? token, DateTime? expiryDate, String? identity) async {
    final prefs = await SharedPreferences.getInstance();
    final userData = jsonEncode({
      'identity': identity,
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
        body: jsonEncode({
          'email': email.trim(),
          'password': password.trim(),
        }),
        headers: {"Content-Type": "application/json"},
      );
      final responseData = json.decode(response.body);

      if (response.statusCode != 200) {
        throw HttpException(jsonDecode(response.body)['message']);
      }

      if (responseData["role"] == "laposte" ||
          responseData["role"] == "admin") {
        if (responseData["success"]) {
          _identity = responseData["identity"];
          _token = responseData["token"];
          _expiryDate = JwtDecoder.getExpirationDate(responseData["token"]);
          await _setSharedPreference(_token, _expiryDate, _identity);
          notifyListeners();
          _autoLogout();
        }
        return responseData;
      } else {
        var message = responseData["token"] != null
            ? "Vous n'??tes pas autoris?? ?? vous connecter"
            : responseData["message"];
        return {'success': false, 'message': message};
      }
    } catch (e) {
      throw HttpException(e.toString());
    }
  }

  Future<bool> tryAutoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey("userData")) {
      return false;
    }

    final extractedData =
        jsonDecode(prefs.getString("userData")!) as Map<String, Object>;
    final expiryDate = DateTime.parse(extractedData['expiryDate'] as String);
    if (expiryDate.isBefore(DateTime.now())) {
      return false;
    }

    _token = extractedData["token"] as String;
    _expiryDate = expiryDate;
    _identity = extractedData["identity"] as String;
    notifyListeners();
    _autoLogout();
    return true;
  }

  Future<void> logout() async {
    if (_authTimer != null) {
      _authTimer!.cancel();
      _authTimer = null;
    }

    // final url = Uri.parse("${ConstantVariables.startingURL}/logout");
    // await http.get(url, headers: {'Authorization': "Bearer $_token"});

    _token = null;
    _expiryDate = null;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('userData');
  }

  void _autoLogout() {
    if (_authTimer != null) _authTimer!.cancel();
    final timeToExpired = _expiryDate!.difference(DateTime.now()).inSeconds;
    _authTimer = Timer(Duration(seconds: timeToExpired), logout);
  }
}
