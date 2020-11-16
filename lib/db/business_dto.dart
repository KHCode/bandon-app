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

  bool get isNull => [
        name,
        aboutUs,
        permalink,
        categories,
        address,
        phone,
        website,
        hours,
        highlights
      ].contains(null);
}
