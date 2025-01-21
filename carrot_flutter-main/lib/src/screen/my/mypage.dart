import 'package:carrot_flutter/src/controller/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../model/user_model.dart';
import '../../widget/listitem/user_mypage.dart';
import 'webpage.dart';

class MyPage extends StatelessWidget {
  const MyPage({super.key});

  @override
  Widget build(BuildContext context) {
    final userController = Get.put(UserController());
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 프로필
            // UserMypage(UserModel(id: 1, name: '홍길동')),
            Obx(
              () {
                if (userController.my.value == null) {
                  return const CircularProgressIndicator();
                } else {
                  return UserMypage(userController.my.value!);
                }
              },
            ),

            // 기타메뉴
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(
                '나의 거래',
                style: Theme.of(context).textTheme.labelLarge,
              ),
            ),
            ListTile(
              title: const Text('판매내역'),
              leading: const Icon(Icons.receipt_long_outlined),
            ),
            ListTile(
              title: const Text('로그아웃'),
              leading: const Icon(Icons.logout_outlined),
            ),
            const Divider(),
            ListTile(
              title: const Text('이용약관'),
              onTap: () {
                Get.to(() => const WebPage('이용약관', '/page/terms'));
              },
            ),
            ListTile(
              title: const Text('개인정보 처리방침'),
              onTap: () {
                Get.to(() => const WebPage('개인정보 처리방침', '/page/policy'));
              },
            ),
          ],
        ),
      ),
    );
  }
}
