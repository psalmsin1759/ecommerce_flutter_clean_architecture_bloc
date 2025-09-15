import 'dart:convert';
import 'package:julybyoma_app/features/auth/data/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class AuthLocalService {
  Future<bool> isLoggedIn();
  Future<void> logout();
  Future<void> saveUser(UserModel user);
  Future<UserModel?> getUser();
}

class AuthLocalServiceImpl extends AuthLocalService {
  static const _tokenKey = "token";
  static const _userKey = "user";

  @override
  Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenKey) != null;
  }

  @override
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  @override
  Future<void> saveUser(UserModel user) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = jsonEncode(user.toJson());
    await prefs.setString(_userKey, jsonString);
  }

  @override
  Future<UserModel?> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    final userString = prefs.getString(_userKey);

    if (userString != null) {
      final Map<String, dynamic> json = jsonDecode(userString);
      return UserModel.fromJson(json);
    }
    return null;
  }
}
