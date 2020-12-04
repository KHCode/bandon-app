import 'package:flutter/material.dart';

ListTile navDrawerListTile(String displayName, routeScreen, context) {
  return ListTile(
    title: Text(
      displayName,
      style: const TextStyle(color: Colors.white, fontSize: 20.0),
    ),
    onTap: () => Navigator.of(context).pushNamed(routeScreen.routeName),
  );
}
