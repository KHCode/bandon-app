class EventDTO {
  String title;
  String description;
  String permalink;
  DateTime startDate;
  DateTime endDate;
  String dateDetails;
  String location;
  String admission;
  String website;
  String contact;
  String email;

  EventDTO();

  EventDTO.nullEvent() : title = null;

  bool get isNull => [
        title,
        description,
        permalink,
        startDate,
        endDate,
        dateDetails,
        location,
        admission,
        website,
        contact,
        email
      ].contains(null);
}
