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
  final String message;

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
      this.contactBy,
      this.message});

  Map toJson() => {
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
        'phone': phone,
        'business': business,
        'address1': address1,
        'address2': address2,
        'city': city,
        'state': state,
        'zip': zip,
        'country': country,
        'lodging': lodging,
        'dining': dining,
        'todo': todo,
        'moving': moving,
        'joining': joining,
        'volunteer': volunteer,
        'contactBy': contactBy,
        'message': message
      };
}
