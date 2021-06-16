import 'dart:developer';

import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:mydiary/src/models/entry.dart';
import 'package:mydiary/src/providers/entry_provider.dart';
import 'package:mydiary/src/screens/entry_update.dart';
import 'package:mydiary/src/screens/entry_insert.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

var entryProvider;

class CalendarList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    entryProvider = Provider.of<EntryProvider>(context);


    return Scaffold(
      body: SfCalendar(
        view: CalendarView.month,
        firstDayOfWeek: 1,
        dataSource: MeetingDataSource(getAppointments()),
        allowViewNavigation: true,
      ),
    );
  }
}

List<Appointment> getAppointments() {
  List<Appointment> meetings = <Appointment>[];
  final DateTime today = DateTime.now();
  final DateTime startTime =
  DateTime(today.year, today.month, today.day, 9, 0, 0);
  final DateTime endTime = startTime.add(const Duration(hours: 2));

  


  meetings.add(Appointment(
      startTime: startTime,
      endTime: endTime,
      subject: 'Board Meeting',
      color: Colors.blue,
      isAllDay: true));

  return meetings;
}

class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<Appointment> source) {
    appointments = source;
  }
}