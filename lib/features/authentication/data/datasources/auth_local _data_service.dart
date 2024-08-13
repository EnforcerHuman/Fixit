import 'dart:ffi';

import 'package:shared_preferences/shared_preferences.dart';

class AuthLocalDataService {
  static const String _isLoggedInKey = 'isLoggedIn';
  static const String _userKey = 'userId';
  static const String _userName = 'userName';
  static Future<void> setLoginStatus(bool isloggedin) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(_isLoggedInKey, isloggedin);
  }

  static Future<bool> getLoggedInstatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_isLoggedInKey) ?? false;
  }

  static Future<void> setUserName(String userName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(_userName, userName);
  }

  static Future<String> getUserName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_userName) ?? '';
  }

  static Future<void> setUserKey(String userId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(_userKey, userId);
  }

  static Future<String> getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_userKey) ?? '';
  }
}
