import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webfeed/webfeed.dart';

import '../models/article.dart';

class NewsScreen extends StatelessWidget {
  static const routeName = 'newsScreen';

  const NewsScreen({Key key}) : super(key: key);

  Future<List<Article>> _getNews() async {
    const FEED_URL = 'https://www.bandon.com/feed/';
    final _articles = <Article>[];

    final _response = await http.get(FEED_URL);
    final _channel = RssFeed.parse(_response.body);

    for (final item in _channel.items) {
      _articles.add(Article(
          title: item.title,
          datePublished: item.pubDate,
          permalink: item.link));
    }

    return _articles;
  }

  Future<void> _launchUrl(String articleUrl) async {
    if (await canLaunch(articleUrl)) {
      await launch(
        articleUrl,
        forceSafariVC: true,
        forceWebView: true,
        enableJavaScript: true,
      );
    } else {
      throw 'Could not launch $articleUrl';
    }
  }

  Widget _createNewsListView(BuildContext context, AsyncSnapshot snapshot) {
    if (snapshot.hasData && snapshot.data.length > 0) {
      final List<Article> articles = snapshot.data;
      return ListView.builder(
        itemCount: articles.length,
        itemBuilder: (BuildContext context, int index) {
          return Column(
            children: <Widget>[
              ListTile(
                title: Text(articles[index].title),
                subtitle: Text(parseDate(articles[index].datePublished)),
                trailing: const Icon(Icons.launch),
                onTap: () => _launchUrl(articles[index].permalink),
              ),
            ],
          );
        },
      );
    } else {
      return const Center(child: CircularProgressIndicator());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('News'),
        ),
        body: FutureBuilder(
          future: _getNews(),
          initialData: [],
          builder: (context, snapshot) =>
              _createNewsListView(context, snapshot),
        ));
  }
}

String parseDate(DateTime dateTime) =>
    '${DateFormat("EEEE',' MMM'.' d',' y").format(dateTime)}';
