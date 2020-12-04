import 'business.dart';

class Directory {
  final List<Business> businesses;

  const Directory({this.businesses});

  int get businessCount => businesses.length;

  static const combinedCategories = [
    'All Dining',
    'All Lodging',
    'Wine, Beer & Sprits',
  ];

  List<Business> getByCategory(String category) =>
      (category?.isEmpty ?? true) ? businesses : filterBusinesses(category);

  List<Business> filterBusinesses(String category) {
    Iterable<Business> filteredList;

    switch (category) {
      case 'Favorites':
        filteredList = businesses.where((element) => element.isFavorite);
        break;
      case 'All Dining':
        filteredList = businesses.where((element) => element.categories
            .contains(RegExp(
                r'(Bakeries)|(Farmers Markets)|(Grocery & Deli)|(Restaurants)|(Specialty Food Sellers)',
                caseSensitive: false)));
        break;
      case 'All Lodging':
        filteredList = businesses.where((element) => element.categories
            .contains(RegExp(
                r'(B&B)|(Camping & RV)|(Property Management)|(Resorts, Hotels, Motels)|(Vacation Rentals)',
                caseSensitive: false)));
        break;
      case 'Wine, Beer & Sprits':
        filteredList = businesses.where((element) => element.categories
            .contains(RegExp(r'(Bars and Pubs)|(Wine & Liquor Stores)',
                caseSensitive: false)));
        break;
      default:
        filteredList = businesses
            .where((element) => element.categories.contains(category));
    }

    return filteredList.toList();
  }

  List<String> get categories => businesses
      .map((business) => business.categories.toString().split(';'))
      .expand((element) => element)
      .toSet()
      .toList()
        ..addAll(combinedCategories)
        ..sort()
        ..insert(0, 'Favorites');
}
