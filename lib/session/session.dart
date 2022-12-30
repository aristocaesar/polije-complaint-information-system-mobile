import 'package:elapor_polije/session/user_state.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';

class Session {
  final userState = Get.put(UserStateController());

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

  void restoreSession() async {
    userState.setState(
        (await getPreferences()).get("id").toString(),
        (await getPreferences()).get("nama").toString(),
        (await getPreferences()).get("email").toString(),
        (await getPreferences()).get("foto").toString(),
        (await getPreferences()).get("verifikasi_email").toString());
  }

  Future<void> destroySession() async {
    userState.setState("", "", "", "", "");

    await (await getPreferences()).remove("id");
    await (await getPreferences()).remove("nama");
    await (await getPreferences()).remove("email");
    await (await getPreferences()).remove("foto");
    await (await getPreferences()).remove("verifikasi_email");
  }
}
