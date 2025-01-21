import 'package:flutter/material.dart';

class LabelTextField extends StatelessWidget {
  final String label;
  final String hintText;
  final TextEditingController controller;
  final bool isObscure;
  final TextInputType? keyboardType;
  final int maxLines;

  const LabelTextField({
    super.key,
    required this.label,
    required this.hintText,
    required this.controller,
    this.isObscure = false,
    this.keyboardType,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(label, style: Theme.of(context).textTheme.labelLarge),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          obscureText: isObscure,
          maxLines: maxLines,
          keyboardType: TextInputType.phone,
          style: const TextStyle(fontSize: 16),
          decoration: InputDecoration(
            hintText: hintText,
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
