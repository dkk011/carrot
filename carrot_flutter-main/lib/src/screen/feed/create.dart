import 'package:carrot_flutter/src/controller/feed_controller.dart';
import 'package:carrot_flutter/src/controller/file_controller.dart';
import 'package:carrot_flutter/src/widget/button/feed_image.dart';
import 'package:carrot_flutter/src/widget/form/label_textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FeedCreate extends StatefulWidget {
  const FeedCreate({super.key});

  @override
  State<FeedCreate> createState() => _FeedCreateState();
}

class _FeedCreateState extends State<FeedCreate> {
  final feedController = Get.put(FeedController());
  final fileController = Get.put(FileController());
  // int? imageId;
  final _titleController = TextEditingController();
  final _priceController = TextEditingController();
  final _contentController = TextEditingController();

  _submit() async {
    final result = await feedController.feedCreate(
      _titleController.text,
      _priceController.text,
      _contentController.text,
      fileController.imageId.value,
      // imageId,
    );
    if (result) {
      Get.back();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('내 물건 팔기')),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  // 이미지 업로드
                  InkWell(
                    onTap: fileController.upload,
                    child: Obx(
                      () => FeedImage(fileController.imageUrl),
                    ),
                  ),
                  // Row(
                  //   children: [
                  //     Container(
                  //       padding: const EdgeInsets.all(10),
                  //       decoration: BoxDecoration(
                  //         borderRadius: BorderRadius.circular(10),
                  //         border: Border.all(color: Colors.grey, width: 1),
                  //       ),
                  //       child: const Icon(
                  //         Icons.camera_alt_outlined,
                  //         color: Colors.grey,
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  const SizedBox(height: 16),
                  // 제목
                  LabelTextField(
                    label: '제목',
                    hintText: '제목',
                    controller: _titleController,
                  ),
                  // 가격
                  LabelTextField(
                    label: '가격',
                    hintText: '가격을 입력해주세요.',
                    controller: _priceController,
                  ),
                  // 설명
                  LabelTextField(
                    label: '자세한 설명',
                    hintText: '자세한 설명을 입력하세요',
                    controller: _contentController,
                    maxLines: 6,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: ElevatedButton(
                onPressed: _submit,
                child: const Text('작성 완료'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
