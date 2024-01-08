class Event {
  late String name;
  late String date;
  late String location;
  late String type;
  late String participants;
  late String photoUrl;
  late String userUid; // Added userUid field

  Event({
    required this.name,
    required this.date,
    required this.location,
    required this.type,
    required this.participants,
    required this.photoUrl,
    required this.userUid,
  });

  // Convert the Event object to a Map
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'date': date,
      'location': location,
      'type': type,
      'participants': participants,
      'photoUrl': photoUrl,
      'userUid': userUid,
    };
  }

 Event.empty()
      : name = '',
        date = '',
        location = '',
        userUid = '',
        photoUrl = '',
        participants = '',
        type = '';
}