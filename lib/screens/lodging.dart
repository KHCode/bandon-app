import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LodgingScreen extends StatelessWidget {
  static const routeName = 'lodgingScreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Lodging')),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[Text("Hello from lodging")],
        ),
      ),
    );
  }
}
