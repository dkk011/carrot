import 'package:flutter/material.dart';

class ConfirmModal extends StatelessWidget {
  final String title;
  final String message;
  final String confirmText;
  final VoidCallback cancel;
  final VoidCallback confirmAction;
  const ConfirmModal({
    required this.title,
    required this.message,
    required this.confirmText,
    required this.confirmAction,
    required this.cancel,
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: <Widget>[
        TextButton(
          onPressed: cancel,
          child: const Text('취소'),
        ),
        TextButton(
          onPressed: confirmAction,
          child: Text(confirmText),
        ),
      ],
    );
  }
}
