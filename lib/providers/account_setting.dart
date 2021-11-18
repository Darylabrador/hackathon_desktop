import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';

import '../models/http_exception.dart';
import '../utils/constant_variables.dart';

class AccountSetting with ChangeNotifier {
  final String? authToken;
  AccountSetting({this.authToken});
}

