class Event {
  final String title;
  final String description;
  final String permalink;
  final DateTime startDate;
  final DateTime endDate;
  final String dateDetails;
  final String location;
  final String admission;
  final String website;
  final String contact;
  final String email;

  const Event(
      {this.title,
      this.description,
      this.permalink,
      this.startDate,
      this.endDate,
      this.dateDetails,
      this.location,
      this.admission,
      this.website,
      this.contact,
      this.email});
}
