import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/auth_controller.dart';
import '../../controller/file_controller.dart';
import '../../widget/button/circle_image.dart';
import '../../widget/form/label_textfield.dart';
import '../home.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final fileController = Get.put(FileController());
  final authController = Get.put(AuthController());
  final _passwordController = TextEditingController();
  final _passwordConfirmController = TextEditingController();
  final _nameController = TextEditingController();

  _submit() async {
    bool result = await authController.register(
      _passwordController.text,
      _nameController.text,
      fileController.imageId.value,
    );
    if (result) {
      Get.offAll(() => const Home());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('회원 가입')),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: ListView(
          children: [
            InkWell(
              onTap: fileController.upload,
              child: Obx(
                () => CircleImage(fileController.imageUrl),
              ),
            ),
            // 프로필 이미지
            // CircleAvatar(
            //   radius: 40,
            //   backgroundColor: Colors.grey,
            //   child: Icon(
            //     Icons.camera_alt,
            //     color: Colors.white,
            //     size: 30,
            //   ),
            // ),
            const SizedBox(height: 16),
            // 비밀번호
            LabelTextField(
              label: '비밀번호',
              hintText: '비밀번호를 입력해주세요',
              controller: _passwordController,
              isObscure: true,
            ),
            // 비밀번호 확인
            LabelTextField(
              label: '비밀번호 확인',
              hintText: '비밀번호를 한번 더 입력해주세요',
              controller: _passwordConfirmController,
              isObscure: true,
            ),
            // 닉네임
            LabelTextField(
              label: '닉네임',
              hintText: '닉네임을 입력해주세요',
              controller: _nameController,
            ),
            // 버튼
            ElevatedButton(
              onPressed: _submit,
              child: const Text('인증번호 확인'),
            ),
          ],
        ),
      ),
    );
  }
}
