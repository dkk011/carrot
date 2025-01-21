import 'package:carrot_flutter/src/screen/auth/intro.dart';
import 'package:carrot_flutter/src/screen/home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyApp extends StatelessWidget {
  final bool isLogin;
  const MyApp(this.isLogin, {super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: isLogin ? Home() : Intro(),
      theme: ThemeData(
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xffFF7E36),
            padding: const EdgeInsets.symmetric(vertical: 16),
            textStyle:
                const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            foregroundColor: Colors.white,
            minimumSize: const Size(double.infinity, 10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: const Color(0xffFF7E36),
            textStyle: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        inputDecorationTheme: const InputDecorationTheme(
          hintStyle: TextStyle(fontSize: 16, color: Colors.grey),
          floatingLabelStyle: TextStyle(fontSize: 10),
          contentPadding: EdgeInsets.all(10),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
          ),
        ),
        textTheme: const TextTheme(
          labelLarge: TextStyle(
            fontSize: 16,
            fontFamily: 'Noto Sans',
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
