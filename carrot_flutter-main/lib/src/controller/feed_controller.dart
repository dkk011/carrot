import 'dart:math';

import 'package:carrot_flutter/src/model/feed_model.dart';
import 'package:get/get.dart';

import '../provider/feed_provider.dart';

/// 피드 데이터를 관리하는 컨트롤러 클래스
class FeedController extends GetxController {
  /// 피드 API 요청을 처리하는 Provider 인스턴스
  final feedProvider = Get.put(FeedProvider());

  /// 피드 목록을 저장하는 Observable 리스트
  final RxList<FeedModel> feedList = <FeedModel>[].obs;

  final Rx<FeedModel?> currentFeed = Rx<FeedModel?>(null);

  /// 새로운 피드 데이터를 추가하는 메서드
  /// 랜덤한 ID, 제목, 내용, 가격으로 피드를 생성
  void addData() {
    final random = Random();
    final newItem = FeedModel.parse({
      'id': random.nextInt(100),
      'title': '물품 ${random.nextInt(100)}',
      'content': '설명 ${random.nextInt(100)}',
      'price': 500 + random.nextInt(49500),
    });
    feedList.add(newItem);
  }

  /// 기존 피드 데이터를 업데이트하는 메서드
  /// [newData] 업데이트할 새로운 피드 데이터
  void updateData(FeedModel newData) {
    final index = feedList.indexWhere((item) => item.id == newData.id);
    if (index != -1) {
      feedList[index] = newData;
    }
  }

  /// 서버로부터 피드 목록을 가져오는 메서드
  /// [page] 가져올 페이지 번호 (기본값: 1)
  Future<void> feedIndex({int page = 1}) async {
    Map json = await feedProvider.index(page);
    List<FeedModel> tmp =
        json['data'].map<FeedModel>((m) => FeedModel.parse(m)).toList();
    (page == 1) ? feedList.assignAll(tmp) : feedList.addAll(tmp);
  }

  Future<bool> feedCreate(
      String title, String price, String content, int? image) async {
    Map body = await feedProvider.store(title, price, content, image);
    if (body['result'] == 'ok') {
      await feedIndex();
      return true;
    }
    Get.snackbar('생성 에러', body['message'], snackPosition: SnackPosition.BOTTOM);
    return false;
  }

  feedUpdate(int id, String title, String priceString, String content,
      int? image) async {
    // price와 image를 적절한 타입으로 변환
    int price = int.tryParse(priceString) ?? 0; // price를 int로 변환,실패 시 0
    Map body =
        await feedProvider.update(id, title, priceString, content, image);
    if (body['result'] == 'ok') {
      // ID를 기반으로 리스트에서 해당 요소를 찾아 업데이트
      int index = feedList.indexWhere((feed) => feed.id == id);
      if (index != -1) {
        // 찾은 인덱스 위치의 요소를 업데이트
        FeedModel updatedFeed = feedList[index].copyWith(
          title: title,
          price: price,
          content: content,
          imageId: image,
        );
        feedList[index] = updatedFeed; // 특정 인덱스의 요소를 새로운 모델로 교체
      }
      return true;
    }
    Get.snackbar('수정 에러', body['message'], snackPosition: SnackPosition.BOTTOM);
    return false;
  }

  Future<void> feedShow(int id) async {
    Map body = await feedProvider.show(id);
    if (body['result'] == 'ok') {
      currentFeed.value = FeedModel.parse(body['data']);
    } else {
      Get.snackbar('피드 에러', body['message'],
          snackPosition: SnackPosition.BOTTOM);
      currentFeed.value = null;
    }
  }

  Future<bool> feedDelete(int id) async {
    Map body = await feedProvider.destroy(id);
    if (body['result'] == 'ok') {
      feedList.removeWhere((feed) => feed.id == id);
      return true;
    }
    Get.snackbar('삭제 에러', body['message'], snackPosition: SnackPosition.BOTTOM);
    return false;
  }
}
