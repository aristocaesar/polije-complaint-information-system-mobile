import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';

class UserStateController extends GetxController {
  var id = "";
  var namaLengkap = "";
  var email = "";
  var foto =
      "${dotenv.env['BASE_HOST']}/public/upload/assets/images/USER-default.png}";

  void setState(
      String idUser, String namaUser, String emailUser, String fotoUser) {
    id = idUser;
    namaLengkap = namaUser;
    email = emailUser;
    foto = fotoUser;
    update();
  }

  void test(String str) {
    id = str;
  }
}
