import 'package:flutter/material.dart';

class MoreBottom extends StatelessWidget {
  final VoidCallback cancelTap;
  final VoidCallback hideTap;
  final VoidCallback? update;
  final VoidCallback? delete;
  const MoreBottom(
      {super.key,
      required this.cancelTap,
      required this.hideTap,
      this.update,
      this.delete});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  leading: Icon(Icons.visibility_off_outlined),
                  title: Text('이 글 숨기기'),
                  onTap: () {
                    hideTap();
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                    leading: Icon(Icons.help_outline),
                    title: Text('게시글 노출 기준')),
                ListTile(
                  leading:
                      Icon(Icons.warning_amber_outlined, color: Colors.red),
                  title: Text('신고하기'),
                  textColor: Colors.red,
                ),
                Visibility(
                  visible: update != null,
                  child: ListTile(
                    leading: const Icon(Icons.update_outlined),
                    title: const Text('수정하기'),
                    onTap: update,
                  ),
                ),
                Visibility(
                  visible: delete != null,
                  child: ListTile(
                    leading: const Icon(Icons.delete_outline),
                    title: const Text('삭제하기'),
                    onTap: delete,
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: ListTile(
              title: Text('닫기', textAlign: TextAlign.center),
              onTap: cancelTap,
            ),
          ),
        ],
      ),
    );
  }
}
