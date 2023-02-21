import 'dart:io';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewState extends StatefulWidget {
  const WebViewState({super.key, required this.title, required this.url});

  final String title;
  final String url;

  @override
  State<WebViewState> createState() => _WebViewStateState();
}

class _WebViewStateState extends State<WebViewState> {
  int _progress = 0;

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) WebView.platform = AndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          backgroundColor: Colors.black,
        ),
        body: Builder(builder: (_) {
          if (widget.url.isEmpty) {
            return Center(
              child: Text(
                "HomePage/Url Movie Is Not Found",
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            );
          }
          return Stack(
            children: [
              WebView(
                initialUrl: widget.url,
                javascriptMode: JavascriptMode.unrestricted,
                onProgress: (progress) {
                  setState(() {
                    _progress = progress;
                  });
                },
              ),
              _progress < 100
                  ? const Positioned.fill(
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    )
                  : const SizedBox(),
            ],
          );
        }),
      );
    });
  }
}
