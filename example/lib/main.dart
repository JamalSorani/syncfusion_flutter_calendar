import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

void main() {
  return runApp(const CalendarApp());
}

/// The app which hosts the home page which contains the calendar on it.
class CalendarApp extends StatelessWidget {
  const CalendarApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(title: 'Calendar Demo', home: MyHomePage());
  }
}

/// The hove page which hosts the calendar
class MyHomePage extends StatefulWidget {
  /// Creates the home page to display teh calendar widget.
  const MyHomePage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 50),
        child: Column(
          children: [
            Expanded(
              child: SfCalendar(
                view: CalendarView.week, // .week, .day
                showNavigationArrow: true,
                headerStyle: const CalendarHeaderStyle(
                  backgroundColor: Colors.white,
                ),
                backgroundColor: Colors.white,
                viewHeaderStyle: const ViewHeaderStyle(
                  backgroundColor: Colors.white,
                  dayTextStyle: TextStyle(fontSize: 8),
                ),
                monthViewSettings: MonthViewSettings(
                  dayFormat: "EEEE",
                ),

                initialDisplayDate: DateTime.now(),
                dataSource: _getCalendarDataSource(),
                // monthCellBuilder:
                //     (BuildContext context, MonthCellDetails details) {
                //   // for dividers
                //   return Container(
                //     child: Text(details.date.day.toString()),
                //   );
                // },
                customHeaderWidget: (context, details, leftArrow, rightArrow) {
                  return Row(
                    children: [
                      Container(
                        child: Text(
                          details.date.month.toString() +
                              ' ,' +
                              details.date.year.toString(),
                        ),
                      ),
                      leftArrow,
                      rightArrow,
                    ],
                  );
                },

                //* week
              ),
            ),
          ],
        ),
      ),
    );
  }

  CalendarDataSource _getCalendarDataSource() {
    final List<Meeting> appointments = <Meeting>[
      Meeting(
        'Meeting',
        DateTime.now(),
        DateTime.now().add(const Duration(hours: 1)),
        Colors.blue,
        false,
      ),
    ];
    return MeetingDataSource(appointments);
  }
}

/// An object to set the appointment collection data source to calendar, which
/// used to map the custom appointment data to the calendar appointment, and
/// allows to add, remove or reset the appointment collection.
class MeetingDataSource extends CalendarDataSource {
  /// Creates a meeting data source, which used to set the appointment
  /// collection to the calendar
  MeetingDataSource(List<Meeting> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return _getMeetingData(index).from;
  }

  @override
  DateTime getEndTime(int index) {
    return _getMeetingData(index).to;
  }

  @override
  String getSubject(int index) {
    return _getMeetingData(index).eventName;
  }

  @override
  Color getColor(int index) {
    return _getMeetingData(index).background;
  }

  @override
  bool isAllDay(int index) {
    return _getMeetingData(index).isAllDay;
  }

  Meeting _getMeetingData(int index) {
    final dynamic meeting = appointments![index];
    late final Meeting meetingData;
    if (meeting is Meeting) {
      meetingData = meeting;
    }

    return meetingData;
  }
}

/// Custom business object class which contains properties to hold the detailed
/// information about the event data which will be rendered in calendar.
class Meeting {
  /// Creates a meeting class with required details.
  Meeting(this.eventName, this.from, this.to, this.background, this.isAllDay);

  /// Event name which is equivalent to subject property of [Appointment].
  String eventName;

  /// From which is equivalent to start time property of [Appointment].
  DateTime from;

  /// To which is equivalent to end time property of [Appointment].
  DateTime to;

  /// Background which is equivalent to color property of [Appointment].
  Color background;

  /// IsAllDay which is equivalent to isAllDay property of [Appointment].
  bool isAllDay;
}
