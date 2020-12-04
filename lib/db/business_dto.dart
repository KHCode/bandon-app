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

  BusinessDTO();

  BusinessDTO.nullBusiness() : name = null;

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
