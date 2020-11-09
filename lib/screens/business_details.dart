import 'package:flutter/material.dart';
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

    return Scaffold(
      appBar: AppBar(
        title: Text('Business Details'),
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
                Text(
                  _business.website,
                  style: Theme.of(context).textTheme.headline6,
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
  if (MediaQuery.of(context).orientation == Orientation.landscape) {
    return MediaQuery.of(context).size.width * 0.05;
  } else {
    return MediaQuery.of(context).size.width * 0.1;
  }
}
