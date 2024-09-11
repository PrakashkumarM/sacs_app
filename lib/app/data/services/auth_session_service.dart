import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert'; // To use JSON encoding/decoding

class AuthSessionService {
  static const String _isLoggedInKey = 'isLoggedIn';
  static const String _userDataKey = 'userData';

  // Save login session with full user data
  Future<void> saveLoginSession(Map<String, dynamic> userData) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_isLoggedInKey, true);
    // Convert user data map to JSON string and save it
    await prefs.setString(_userDataKey, jsonEncode(userData));
  }

  // Clear login session
  Future<void> clearLoginSession() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_isLoggedInKey);
    await prefs.remove(_userDataKey);
  }

  // Check if user is logged in
  Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_isLoggedInKey) ?? false;
  }

  // Get logged-in user data
  Future<Map<String, dynamic>?> getUserData() async {
    final prefs = await SharedPreferences.getInstance();
    final userDataString = prefs.getString(_userDataKey);

    if (userDataString != null) {
      // Decode JSON string to Map<String, dynamic>
      return jsonDecode(userDataString);
    }
    return null;
  }
}
