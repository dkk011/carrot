import 'package:carrot_flutter/src/widget/listitem/feed_list_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/feed_controller.dart';
import '../../widget/button/category_button.dart';
import 'create.dart';

class FeedIndex extends StatefulWidget {
  const FeedIndex({super.key});
  @override
  State<FeedIndex> createState() => _FeedIndexState();
}

class _FeedIndexState extends State<FeedIndex> {
  final FeedController feedController =
      Get.put<FeedController>(FeedController());
  int _currentPage = 1;

  bool _onNotification(ScrollNotification scrollInfo) {
    if (scrollInfo is ScrollEndNotification &&
        scrollInfo.metrics.extentAfter == 0) {
      feedController.feedIndex(page: ++_currentPage);
      return true;
    }
    return false;
  }

  Future<void> _onRefresh() async {
    _currentPage = 1;
    await feedController.feedIndex();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => const FeedCreate());
        },
        tooltip: '항목 추가',
        shape: const CircleBorder(),
        backgroundColor: Theme.of(context).primaryColor,
        child: const Icon(Icons.add, color: Colors.white),
      ),
      appBar: AppBar(
        centerTitle: false,
        title: Text('시흥시 정왕동'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.search),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.notifications_none_rounded),
          ),
        ],
      ),
      body: Column(
        children: [
          SizedBox(
            height: 40,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: const [
                CategoryButton(icon: Icons.menu),
                SizedBox(width: 12),
                CategoryButton(icon: Icons.search, title: '알바'),
                SizedBox(width: 12),
                CategoryButton(icon: Icons.home, title: '부동산'),
                SizedBox(width: 12),
                CategoryButton(icon: Icons.car_crash, title: '중고차'),
                SizedBox(width: 12),
              ],
            ),
          ),
          Expanded(
              child: Obx(() => NotificationListener<ScrollNotification>(
                    onNotification: _onNotification,
                    child: RefreshIndicator(
                      onRefresh: _onRefresh,
                      child: ListView.builder(
                          itemCount: feedController.feedList.length,
                          itemBuilder: (context, index) {
                            final item = feedController.feedList[index];
                            return FeedListItem(item);
                          }),
                    ),
                  )))
        ],
      ),
    );
  }
}
