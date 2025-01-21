import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../model/user_model.dart';
import '../../screen/my/myedit.dart';

class UserMypage extends StatelessWidget {
  final UserModel user;
  const UserMypage(this.user, {super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.to(() => const MyEdit());
      },
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(user.profileUrl),
                ),
                const SizedBox(width: 12),
                Text(
                  user.name,
                  style: Theme.of(context).textTheme.labelLarge,
                ),
              ],
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(4),
              ),
              padding: const EdgeInsets.all(8),
              child: const Text(
                '프로필 보기',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
              ),
            )
          ],
        ),
      ),
    );
  }
}
