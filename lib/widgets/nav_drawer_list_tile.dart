import 'package:flutter/material.dart';

ListTile navDrawerListTile(String displayName, routeScreen, context) {
  return ListTile(
    title: Text(
      displayName,
      style: TextStyle(color: Colors.white, fontSize: 20),
    ),
    onTap: () => Navigator.of(context).pushNamed(routeScreen.routeName),
  );
}
