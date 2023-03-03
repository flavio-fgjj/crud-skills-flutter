import 'package:shared_preferences/shared_preferences.dart';

class SecurityPreferences {
  SharedPreferences? preferences;

  Future<void> initializePreference(String userId) async {
    preferences = await SharedPreferences.getInstance();
    preferences?.setString("userId", userId);
  }

  Future<String> getUserId() async {
    preferences = await SharedPreferences.getInstance();
    String? aux = preferences?.getString("userId");
    return aux ?? "";
  }
}