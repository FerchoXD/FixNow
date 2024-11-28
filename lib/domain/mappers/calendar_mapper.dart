import 'package:fixnow/domain/entities/calendar_supplier.dart';

class CalendarMapper {
  static CalendarSupplier calendarJsonToEntity(Map<String, dynamic> json) {
    return CalendarSupplier(
      uuid: json['uuid'],
      userUuid: json['userUuid'],
      day: json['day'],
      active: json['active'],
      start: json['start'],
      end: json['end'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }
}
