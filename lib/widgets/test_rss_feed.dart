import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:http/http.dart' as http;
import 'package:webfeed/webfeed.dart';

class TestRssFeed extends StatefulWidget {
  @override
  _TestRssFeedState createState() => _TestRssFeedState();
}

class _TestRssFeedState extends State<TestRssFeed> {
  final client = http.Client();
  Html articleBody;

  @override
  void initState() {
    super.initState();
    getOneArticle();
  }

  void getOneArticle() async {
    final response = await client.get('https://www.bandon.com/feed/');
    final channel = RssFeed.parse(response.body);

    final item = channel.items.first;
    final itemSource = item.content.value;
    final html = Html(
      data: itemSource,
    );

    client.close();

    setState(() {
      articleBody = html;
    });
  }

  @override
  Widget build(BuildContext context) {
    return articleBody;
  }
}
