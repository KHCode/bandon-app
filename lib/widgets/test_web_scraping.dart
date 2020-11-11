import 'package:flutter/material.dart';
import 'package:web_scraper/web_scraper.dart';

class TestWebScraping extends StatefulWidget {
  @override
  _TestWebScrapingState createState() => _TestWebScrapingState();
}

class _TestWebScrapingState extends State<TestWebScraping> {
  String description;

  @override
  void initState() {
    super.initState();
    getAboutUs();
  }

  void getAboutUs() async {
    final rawUrl =
        'https://tourism.bandon.com/list/member/7-devils-brewing-co-coos-bay-1';
    final webScraper = WebScraper('https://tourism.bandon.com');
    final endpoint = rawUrl.replaceAll(r'https://tourism.bandon.com', '');
    if (await webScraper.loadWebPage(endpoint)) {
      final _aboutUsDescription =
          webScraper.getElement('div.gz-details-about > div.col > p', []);

      setState(() {
        description = _aboutUsDescription.first['title'];
      });
    } else {
      print('Failed to load the description');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16.0, 200.0, 16.0, 16.0),
      child: Text(description, style: const TextStyle(fontSize: 22.0)),
    );
  }
}
