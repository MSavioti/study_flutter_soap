class TrackingEvent {
  final DateTime time;
  final String description;
  final String place;
  final String city;
  final String state;

  TrackingEvent({
    required this.time,
    required this.description,
    required this.place,
    required this.city,
    required this.state,
  });

  factory TrackingEvent.fromJson(Map<String, dynamic> data) {
    return TrackingEvent(
      time: data['time'],
      description: data['description'],
      place: data['place'],
      city: data['city'],
      state: data['state'],
    );
  }
}
