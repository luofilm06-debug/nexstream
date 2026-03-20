
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PlayPage extends StatefulWidget {
  final String videoUrl;

  const PlayPage({super.key, required this.videoUrl});

  @override
  State<PlayPage> createState() => _PlayPageState();
}

class _PlayPageState extends State<PlayPage> {
  late final WebViewController controller;

  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse(widget.videoUrl));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Player'),
      ),
      body: WebViewWidget(
        controller: controller,
      ),
    );
  }
}
