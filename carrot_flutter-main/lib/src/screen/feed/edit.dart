import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/feed_controller.dart';
import '../../controller/file_controller.dart';
import '../../model/feed_model.dart';
import '../../widget/button/feed_image.dart';
import '../../widget/form/label_textfield.dart';

class FeedEdit extends StatefulWidget {
  final FeedModel model;
  const FeedEdit(this.model, {super.key});
  @override
  State<FeedEdit> createState() => _FeedEditState();
}

class _FeedEditState extends State<FeedEdit> {
  final feedController = Get.put(FeedController());
  final fileController = Get.put(FileController());
  // int? imageId;
  final _titleController = TextEditingController();
  final _priceController = TextEditingController();
  final _contentController = TextEditingController();

  _submit() async {
    final result = await feedController.feedUpdate(
      widget.model.id,
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
  void initState() {
    super.initState();
// 초기화 이후 TextField에 값을 채워주기 위한 작업
    _titleController.text = widget.model.title;
    _priceController.text = widget.model.price.toString();
    _contentController.text = widget.model.content;
    fileController.imageId.value = widget.model.imageId;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('물건 정보 수정')),
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
