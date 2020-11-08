class ContactInfo {
  final String firstName;
  final String lastName;
  final String email;
  final String phone;
  final String business;
  final String address1;
  final String address2;
  final String city;
  final String state;
  final int zip;
  final String country;
  final bool lodging;
  final bool dining;
  final bool todo;
  final bool moving;
  final bool joining;
  final bool volunteer;
  final String contactBy;

  const ContactInfo(
      {this.firstName,
      this.lastName,
      this.email,
      this.phone,
      this.business,
      this.address1,
      this.address2,
      this.city,
      this.state,
      this.zip,
      this.country,
      this.lodging,
      this.dining,
      this.todo,
      this.moving,
      this.joining,
      this.volunteer,
      this.contactBy});
}
