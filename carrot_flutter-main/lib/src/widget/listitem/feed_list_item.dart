import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../main.dart';
import '../../controller/feed_controller.dart';
import '../../model/feed_model.dart';
import '../../screen/feed/edit.dart';
import '../../screen/feed/show.dart';
import '../modal/confirm_modal.dart';
import '../modal/more_bottom.dart';

// 이미지 크기
const double _imageSize = 110;

class FeedListItem extends StatelessWidget {
  final FeedModel item;
  const FeedListItem(this.item, {super.key});

  @override
  Widget build(BuildContext context) {
    final FeedController feedController = Get.put(FeedController());
    return InkWell(
      onTap: () {
        Get.to(() => FeedShow(item.id));
      },
      child: Stack(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 이미지 영역
              ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: Image.network(
                  item.imageUrl,
                  // "https://www.spongebobshop.com/cdn/shop/products/SB-Standees-Spong-1_1200x.jpg?v=1603744567",
                  width: _imageSize,
                  height: _imageSize,
                  fit: BoxFit.cover,
                ),
              ),

              // 정보 영역
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.title,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 16),
                      ),
                      Row(
                        children: [
                          // Text(
                          //   '동네이름',
                          //   style: TextStyle(color: Colors.grey),
                          // ),
                          Text(
                            TimeUtil.parse(item.createdAt),
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                      Text(
                        '${item.price} 원',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
              // 기타 영역
              IconButton(
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return MoreBottom(
                        cancelTap: () {
                          Get.back();
                        },
                        hideTap: () {},
                        update: () {
                          Get.back();
                          Get.to(() => FeedEdit(item));
                        },
                        delete: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return ConfirmModal(
                                title: '삭제 하기',
                                message: '이 글을 삭제하시겠습니까?',
                                confirmText: '삭제하기',
                                confirmAction: () async {
                                  bool result =
                                      await feedController.feedDelete(item.id);
                                  if (result) {
                                    Get.back();
                                    Get.back();
                                  }
                                },
                                cancel: () {
                                  Get.back();
                                },
                              );
                            },
                          );
                        },
                      );
                    },
                  );
                },
                icon: const Icon(Icons.more_vert, color: Colors.grey, size: 16),
              ),
            ],
          ),
          // 채팅, 관심물건 창 배치
          Positioned(
            right: 10,
            bottom: 0,
            child: Row(
              children: [
                Icon(Icons.chat_bubble_outline, color: Colors.grey, size: 16),
                SizedBox(width: 2),
                Text('1', style: TextStyle(color: Colors.grey)),
                SizedBox(width: 4),
                Icon(Icons.favorite_border, color: Colors.grey, size: 16),
                SizedBox(width: 2),
                Text('1', style: TextStyle(color: Colors.grey)),
              ],
            ),
          )
        ],
      ),
    );
  }
}
