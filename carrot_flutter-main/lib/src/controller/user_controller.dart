import 'package:get/get.dart';

import '../model/user_model.dart';
import '../provider/user_provider.dart';

class UserController extends GetxController {
  final provider = Get.put(UserProvider());
  final Rx<UserModel?> my = Rx<UserModel?>(null);
  Future<void> myInfo() async {
    Map body = await provider.show();
    if (body['result'] == 'ok') {
      my.value = UserModel.parse(body['data']);
      return;
    }
    Get.snackbar('회원 에러', body['message'], snackPosition: SnackPosition.BOTTOM);
  }

  Future<bool> updateInfo(String name, int? image) async {
    Map body = await provider.update(name, image);
    if (body['result'] == 'ok') {
      my.value = UserModel.parse(body['data']);
      return true;
    }
    Get.snackbar('수정 에러', body['message'], snackPosition: SnackPosition.BOTTOM);
    return false;
  }
}
