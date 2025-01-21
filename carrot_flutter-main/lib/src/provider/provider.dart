import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../shared/global.dart';

/// API 요청을 처리하는 기본 Provider 클래스
class Provider extends GetConnect {
  final box = GetStorage();

  @override
  void onInit() {
    // 자체 서명된 인증서 허용
    allowAutoSignedCert = true;
    // API 서버 기본 URL 설정
    httpClient.baseUrl = Global.baseUrl;
    // 모든 요청에 JSON 응답 형식 지정
    httpClient.addRequestModifier<void>((request) {
      request.headers['Accept'] = 'application/json';
      if (request.url.toString().contains('/api/')) {
        request.headers['Authorization'] = 'Bearer ${box.read('access_token')}';
      }
      return request;
    });
    super.onInit();
  }
}
