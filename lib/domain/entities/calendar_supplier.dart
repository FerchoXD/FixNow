class CalendarSupplier {
  final String uuid;
  final String userUuid;
  final String day;
  final bool active;
  final String? start;
  final String? end;
  final DateTime createdAt;
  final DateTime updatedAt;

  CalendarSupplier({
    required this.uuid,
    required this.userUuid,
    required this.day,
    required this.active,
    this.start,
    this.end,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  String toString() {
    return '''
CalendarSupplier(
  uuid: $uuid,
  userUuid: $userUuid,
  day: $day,
  active: $active,
  start: $start,
  end: $end,
  createdAt: $createdAt,
  updatedAt: $updatedAt,
)
''';
  }
}
