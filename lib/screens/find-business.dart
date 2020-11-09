import 'package:flutter/material.dart';

import 'business_details.dart';
import '../db/database_manager.dart';
import '../models/business.dart';
// import '../widgets/app_gradient_background.dart';
import '../widgets/settings_drawer.dart';
// import '../widgets/styled_section_banner.dart';
// import '../widgets/styled_top_banner.dart';

class FindBusinessScreen extends StatefulWidget {
  static const routeName = 'findBusinessScreen';

  @override
  _FindBusinessScreenState createState() => _FindBusinessScreenState();
}

class _FindBusinessScreenState extends State<FindBusinessScreen> {
  Future<List<Business>> _getBusinesses() async {
    final databaseManager = DatabaseManager.getInstance();
    return await databaseManager.getBusinesses();
  }

  void pushBusinessDetails(BuildContext context, Business business) =>
      Navigator.of(context)
          .pushNamed(BusinessDetails.routeName, arguments: business);

  void _toggleFavorite(Business business) {
    final databaseManager = DatabaseManager.getInstance();
    databaseManager.setFavoriteBusiness(
        permalink: business.permalink, isFavorite: !business.isFavorite);
    print(business.isFavorite);
    setState(() {});
  }

  Widget _createBusinessesListView(
      BuildContext context, AsyncSnapshot snapshot) {
    if (snapshot.hasData && snapshot.data.length > 0) {
      return ListView.builder(
        itemCount: snapshot.data.length,
        itemBuilder: (BuildContext context, int index) {
          return Column(
            children: <Widget>[
              ListTile(
                leading: InkWell(
                  child: Icon(snapshot.data[index].isFavorite
                      ? Icons.favorite
                      : Icons.favorite_outline),
                  onTap: () => {_toggleFavorite(snapshot.data[index])},
                ),
                title: Text(snapshot.data[index].name),
                trailing: Icon(Icons.navigate_next),
                onTap: () => pushBusinessDetails(context, snapshot.data[index]),
              ),
            ],
          );
        },
      );
    } else {
      return Center(child: CircularProgressIndicator());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Find a Business'),
      ),
      endDrawer: SettingsDrawer(),
      body: FutureBuilder(
        future: _getBusinesses(),
        initialData: [],
        builder: (context, snapshot) {
          return _createBusinessesListView(context, snapshot);
        },
      ),
    );
  }
}
