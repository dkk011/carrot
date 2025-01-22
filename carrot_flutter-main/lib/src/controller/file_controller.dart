import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../provider/file_provider.dart';
import '../shared/global.dart';

class FileController extends GetxController {
  final ImagePicker picker = ImagePicker();
  final provider = Get.put(FileProvider());
  final imageId = Rx<int?>(null);

  String? get imageUrl =>
      imageId.value != null ? "${Global.baseUrl}/file/${imageId.value}" : null;

  Future<void> upload() async {
    final XFile? image = await picker.pickImage(
      source: ImageSource.gallery,
    );
    if (image == null) return;
    Map body = await provider.imageUpload(
      image.name,
      image.path,
    );
    if (body['result'] == 'ok') {
      imageId.value = body['data'] as int;
    }
  }
}
