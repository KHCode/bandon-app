class BusinessDTO {
  String name;
  String aboutUs;
  String permalink;
  String categories;
  String address;
  String phone;
  String website;
  String hours;
  String highlights;

  // TODO: Check SQL "NOT NULL" fields, permalink is always found when getting details
  bool get isNull =>
      (name?.isEmpty ?? true) &&
      (aboutUs?.isEmpty ?? true) &&
      (permalink?.isEmpty ?? true) &&
      (categories?.isEmpty ?? true) &&
      (address?.isEmpty ?? true) &&
      (phone?.isEmpty ?? true) &&
      (website?.isEmpty ?? true) &&
      (hours?.isEmpty ?? true) &&
      (highlights?.isEmpty ?? true);
}
