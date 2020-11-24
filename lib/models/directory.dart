import 'business.dart';

class Directory {
  final List<Business> businesses;

  const Directory({this.businesses});

  int get businessCount => businesses.length;

  List<Business> getByCategory(String category) => (category?.isEmpty ?? true)
      ? businesses
      : businesses
          .where((element) => element.categories.contains(category))
          .toList();

  List<String> get categories => businesses
      .map((business) => business.categories.toString().split(';'))
      .expand((element) => element)
      .toSet()
      .toList()
        ..sort();
}
