import 'dart:io';

import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/business.dart';

class BusinessDetails extends StatefulWidget {
  static const routeName = 'businessDetails';

  BusinessDetails({Key key}) : super(key: key);

  @override
  _BusinessDetailsState createState() => _BusinessDetailsState();
}

class _BusinessDetailsState extends State<BusinessDetails> {
  Business _business;

  @override
  Widget build(BuildContext context) {
    if (ModalRoute.of(context).settings.arguments is Business) {
      _business = ModalRoute.of(context).settings.arguments;
    }

    void launchMap(address) async {
      var url =
          Uri.parse('https://www.google.com/maps/search/?api=1&query=$address')
              .toString();
      if (Platform.isIOS) {
        url = Uri.parse('http://maps.apple.com/?q=$address').toString();
      }
      if (await canLaunch(url)) {
        await launch(url);
      }
    }

    void launchPhone(phoneNumber) async {
      if (await canLaunch('tel:{phoneNumber}')) {
        await launch(phoneNumber);
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Business Details'),
        actions: <Widget>[
          if (_business?.phone?.isNotEmpty ?? false)
            IconButton(
              onPressed: () => launchPhone(_business.phone),
              icon: Icon(Icons.phone),
            ),
          IconButton(
            onPressed: () =>
                Share.share('Check this out: ${_business.permalink}'),
            icon: Icon(Icons.share),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(padding(context)),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text(
                  _business.name,
                  style: Theme.of(context).textTheme.headline4,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 10),
                if (_business?.categories?.isNotEmpty ?? false)
                  Text(
                    '${_business.categories.replaceAll(';', '\n')}',
                  ),
                SizedBox(height: 10),
                _business?.address?.isEmpty ?? true
                    ? null
                    : InkWell(
                        onTap: () => launchMap(_business.address),
                        child: Text(
                          _business.address,
                          style: Theme.of(context).textTheme.headline6,
                        ),
                      ),
                SizedBox(height: 20),
                Text(
                  _business.aboutUs,
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ]),
        ),
      ),
    );
  }
}

double padding(BuildContext context) {
  return (MediaQuery.of(context).orientation == Orientation.landscape)
      ? MediaQuery.of(context).size.width * 0.05
      : MediaQuery.of(context).size.width * 0.1;
}
