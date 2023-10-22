import 'dart:convert';

import 'package:fav_place/data/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class UserLocalDS {
  Future<User> getUser();
  Future<bool> hasSignUp();
  Future<void> setUser(User u);
}

class UserLocalDSImpl implements UserLocalDS {
  @override
  Future<User> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    final String signedUser = prefs.getString("signedUpUser") ?? "";
    final Map userDecode = jsonDecode(signedUser);
    final User user = User.fromMap(userDecode);
    return user;
  }

  @override
  Future<bool> hasSignUp() async {
    final prefs = await SharedPreferences.getInstance();
    final String signedUser = prefs.getString("signedUpUser") ?? "";
    if (signedUser.isEmpty) {
      return false;
    } else {
      return true;
    }
  }

  @override
  Future<void> setUser(User u) async {
    final prefs = await SharedPreferences.getInstance();
    final String userEncode = jsonEncode(u.toMap());
    await prefs.setString("signedUpUser", userEncode);
  }
}
