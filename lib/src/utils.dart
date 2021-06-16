import 'dart:collection';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class EventListDateTime {
  static late Map<DateTime, List<Event>> _eventAtt = {
    DateTime.utc(2021,03,21): [Event("Trip to Kandy")],
  };

  static changeDate(DateTime date, String event) {
    _eventAtt.addAll({date: [Event(event)]});
  }

  static Map<DateTime, List<Event>> get eventAtt => _eventAtt;
}

class Event {
  final String title;

  const Event(this.title);

  @override
  String toString() => title;
}


final kEvents = LinkedHashMap<DateTime, List<Event>>(
  equals: isSameDay,
  hashCode: getHashCode,
)..addAll(_kEventSource);

final _kEventSource = {
  DateTime.utc(2021,03,26): [Event("Trip to Kandy and Matale")],
  DateTime.utc(2021,06,01): [Event("Medical Checkups")],
  DateTime.utc(2020,12,31): [Event("New Year Resolutions")],
  DateTime.utc(2021,03,01): [Event("My New Job")],
  DateTime.utc(2021,06,02): [Event("My Weight Loss Routine")],
  DateTime.utc(2021,06,15): [Event("Meeting Discussion Log")],
  DateTime.utc(2021,06,16): [Event("My First Charity Programme"),Event("My First Eldar Charity Programme")],
};

int getHashCode(DateTime key) {
  return key.day * 1000000 + key.month * 10000 + key.year;
}


List<DateTime> daysInRange(DateTime first, DateTime last) {
  //final entryProvider = Provider.of<EntryProvider>(BuildContext);
  final dayCount = last.difference(first).inDays + 1;
  return List.generate(
    dayCount,
        (index) => DateTime.utc(first.year, first.month, first.day + index),
  );
}

final kNow = DateTime.now();
final kFirstDay = DateTime(kNow.year, kNow.month - 3, kNow.day);
final kLastDay = DateTime(kNow.year, kNow.month + 3, kNow.day);