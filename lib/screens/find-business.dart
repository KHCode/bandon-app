import 'package:flutter/material.dart';

import 'business_details.dart';
import '../db/database_manager.dart';
import '../models/business.dart';
import '../models/directory.dart';
// import '../widgets/app_gradient_background.dart';
import '../widgets/settings_drawer.dart';
import '../widgets/categories_dropdown_menu.dart';
// import '../widgets/styled_section_banner.dart';
// import '../widgets/styled_top_banner.dart';

class FindBusinessScreen extends StatefulWidget {
  static const routeName = 'findBusinessScreen';

  @override
  FindBusinessScreenState createState() => FindBusinessScreenState();
}

class FindBusinessScreenState extends State<FindBusinessScreen> {
  var _category;
  var argsRead = false;
  List<Business> businesses = [];
  Directory directory;
  List<String> categories;

  @override
  void initState() {
    super.initState();
    _getBusinesses();
  }

  Future<void> _getBusinesses() async {
    final databaseManager = DatabaseManager.getInstance();
    directory = Directory(businesses: await databaseManager.getBusinesses());
    categories = directory.categories;
    setState(() {});
  }

  void pushBusinessDetails(BuildContext context, Business business) =>
      Navigator.of(context)
          .pushNamed(BusinessDetails.routeName, arguments: business);

  Future<void> _toggleFavorite(Business business) async {
    final databaseManager = DatabaseManager.getInstance();
    databaseManager.setFavoriteBusiness(
        permalink: business.permalink, isFavorite: !business.isFavorite);
    await _getBusinesses();
    setState(() {});
  }

  void filterBusinesses(String category) async {
    setState(() {
      _category = category;
    });
  }

  Widget _createBusinessesListView(BuildContext context) {
    if (directory?.businesses?.isEmpty ?? true) {
      return const Center(child: CircularProgressIndicator());
    } else {
      businesses = directory.getByCategory(_category);
      return Column(
        children: [
          CategoriesDropdownMenu(
            values: categories,
            start: _category,
            hint: 'Category',
            onChanged: filterBusinesses,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: businesses.length,
              itemBuilder: (BuildContext context, int index) => ListTile(
                leading: IconButton(
                  icon: Icon(businesses[index].isFavorite
                      ? Icons.favorite
                      : Icons.favorite_border),
                  onPressed: () => _toggleFavorite(businesses[index]),
                ),
                title: Text(businesses[index].name),
                trailing: const Icon(Icons.navigate_next),
                onTap: () => pushBusinessDetails(context, businesses[index]),
              ),
            ),
          ),
        ],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (ModalRoute.of(context).settings.arguments is String &&
        argsRead == false) {
      _category = ModalRoute.of(context).settings.arguments;
      argsRead = true;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Find a Business'),
      ),
      endDrawer: SettingsDrawer(),
      body: _createBusinessesListView(context),
    );
  }
}
