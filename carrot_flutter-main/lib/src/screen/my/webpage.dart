import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../shared/global.dart';

class WebPage extends StatefulWidget {
  final String title;
  final String url;
  const WebPage(this.title, this.url, {super.key});

  @override
  State<WebPage> createState() => _WebPageState();
}

class _WebPageState extends State<WebPage> {
  late WebViewController controller;

  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..loadRequest(
        Uri.parse("${Global.baseUrl}${widget.url}"),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: WebViewWidget(controller: controller),
    );
  }
}
