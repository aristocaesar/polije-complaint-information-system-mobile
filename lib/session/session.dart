import 'package:shared_preferences/shared_preferences.dart';

class Session {
  Future<SharedPreferences> getPreferences() async =>
      await SharedPreferences.getInstance();

  Future<void> setSession(Map<String, dynamic> data) async {
    data.forEach((key, value) async {
      (await getPreferences()).setString(key, value);
    });
  }

  Future<String> get(String key) async {
    return (await getPreferences()).get(key).toString();
  }

  Future<void> destroySession() async {
    await (await getPreferences()).remove("id");
    await (await getPreferences()).remove("nama");
    await (await getPreferences()).remove("email");
    await (await getPreferences()).remove("foto");
  }
}
