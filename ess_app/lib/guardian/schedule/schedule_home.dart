import 'package:ess_app/dataList/schedules.dart';
import 'package:ess_app/utils/dateTime_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../widgets/main_drawer.dart';
import '../../widgets/schedule_monthly_summary.dart';
import '../../widgets/schedule_tab_listview.dart';
import '../create/create_entry_schedule.dart';

class ScheduleHomePage extends StatefulWidget {
  const ScheduleHomePage({super.key});

  @override
  State<ScheduleHomePage> createState() => _ScheduleHomePageState();
}

class _ScheduleHomePageState extends State<ScheduleHomePage> {
// //list for schedule title
//   ScheduleDatabase db = ScheduleDatabase();
//   final _myBox = Hive.box("Schedule_Database");
//   List thisDaySchedule = [];
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();
   CalendarFormat _calendarFormat = CalendarFormat.month;

  @override
  void initState() {
    final filteredDates = scheduleList.where((schedule) {
      final dateTime = extractDatefromDTString(schedule.schedDateTime);
      final input = extractDatefromDTString(DateTime.now().toString());
      return dateTime.contains(input); 

    }).toList();
    print(filteredDates);
    setState(() {
      schedules = filteredDates;
    });
    super.initState();
  }

  List<Schedule> schedules = scheduleList;
  DateTime dateClicked = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'YOUR SCHEDULES',
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Color.fromARGB(255, 255, 197, 6),
        foregroundColor: Colors.black,
        centerTitle: true,
      ),
      drawer: MainDrawer(),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Color.fromARGB(255, 255, 197, 6),
        foregroundColor: Colors.black,
        label: Text('Add Schedule'),
        icon: Icon(Icons.add_box),
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => CreateSchedule()));
        },
      ),
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
          colors: [
            Color.fromARGB(255, 177, 190, 226),
            Color.fromARGB(255, 200, 204, 218),
            Color.fromARGB(255, 214, 174, 175),
            Color.fromARGB(255, 221, 170, 172),
            Color.fromARGB(255, 233, 170, 172),
            Color.fromARGB(255, 233, 148, 151),
            Color.fromARGB(255, 230, 109, 113),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        )),
        child: Column(
          children: [
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Container(
                // child: HeatMapCalendar(
                //   initDate: DateTime.now(),
                //   datasets: {
                //     DateTime(2022, 12, 2): 3,
                //   },
                //   margin: EdgeInsets.all(5),
                //   colorMode: ColorMode.color,
                //   borderRadius: 10,
                //   defaultColor: Colors.grey[200],
                //   textColor: Colors.black,
                //   showColorTip: false,
                //   size: 40,
                //   monthFontSize: 20,
                //   weekFontSize: 14,
                //   weekTextColor: Colors.black,
                //   flexible: true,
                //   colorsets: const {
                //     1: Colors.red,
                //     2: Colors.lightBlue,
                //     3: Colors.orange,
                //     5: Colors.yellow,
                //     7: Colors.green,
                //     9: Colors.blue,
                //     11: Colors.indigo,
                //     13: Colors.purple,
                //   },
                //   onClick: (value){
                //     //date clicked
                //     filterDate(value.toString());
                //   },
                // )
                child: TableCalendar(
                  locale: 'en_US',
                  rowHeight: 60,
                  daysOfWeekHeight: 25,
                  headerStyle: HeaderStyle(
                    decoration: BoxDecoration(
                    ),
                    formatButtonVisible: true, 
                    titleCentered: true,
                    titleTextStyle: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                    ),
                    headerPadding: EdgeInsets.symmetric(vertical: 15.0),
                    leftChevronPadding: EdgeInsets.only(left: 2.0),
                    rightChevronPadding: EdgeInsets.only(right: 2.0),
                  ),
                  daysOfWeekStyle: DaysOfWeekStyle(
                    weekdayStyle: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                    weekendStyle: TextStyle(
                      color: Color.fromARGB(255, 218, 59, 48),
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  calendarStyle: CalendarStyle(
                    outsideDecoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    outsideTextStyle: TextStyle(
                      color: Colors.grey[600],
                      fontWeight: FontWeight.w500,
                      fontSize: 15
                    ),
                    weekendDecoration: BoxDecoration(
                      color: Color.fromARGB(255, 240, 240, 240),
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    weekendTextStyle: TextStyle(
                      color: Color.fromARGB(255, 218, 59, 48),
                      fontWeight: FontWeight.w500,
                      fontSize: 15,
                    ),
                    defaultDecoration: BoxDecoration(
                      color: Color.fromARGB(255, 240, 240, 240),
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    defaultTextStyle: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: 15,
                    ),
                    todayDecoration: BoxDecoration(
                      color: Colors.grey[600],
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    todayTextStyle: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w900,
                      fontSize: 15,
                    ),
                    selectedDecoration: BoxDecoration(
                      color: Color.fromARGB(255, 245, 188, 3),
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    selectedTextStyle: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w900,
                      fontSize: 18,
                    ),
                  ),
                  calendarFormat: _calendarFormat,
                  availableGestures: AvailableGestures.all,
                  firstDay: DateTime.utc(2020),
                  lastDay: DateTime.utc(2050),
                  selectedDayPredicate: (day) {
                    return isSameDay(_selectedDay, day);
                  },
                  onPageChanged: (focusedDay) {
                    _focusedDay = focusedDay;
                  },
                  focusedDay: _focusedDay,
                   onFormatChanged: (format) {
                    if (_calendarFormat != format) {
                      setState(() {
                        _calendarFormat = format;
                      });
                    }
                  },
                  onDaySelected: ((selectedDay, focusedDay) {
                    print(selectedDay);
                    setState(() {
                      _selectedDay = selectedDay;
                      _focusedDay = focusedDay;
                    });
                    filterDate(selectedDay.toString());
                  }),
                ),
               
              ),
            ),
            //schedule tab
            SizedBox(height: 20.0),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xFFE86166),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    topRight: Radius.circular(30.0),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    children: [
                      Container(
                        height: 60,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Center(
                          child: Text(
                            'UPCOMING',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                fontSize: 30),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Expanded(
                        child: Container(
                          child: schedules.isEmpty? 
                          Column(
                            children: [
                              SizedBox(height: 20),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                child: Column(
                                  children: [
                                    Icon(
                                      Icons.event_busy_rounded,
                                      size: 200,
                                      color: Colors.white,
                                    ),
                                    Text(
                                      'No Schedule.',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 25),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          )
                          :ListView.builder(
                          shrinkWrap: true,
                          itemCount: schedules.length,
                          itemBuilder: (context, index) {
                            final schedule = schedules[index];
                            return ScheduleTabListView(
                              title: schedule.schedTitle,
                              dateTime: schedule.schedDateTime,
                              details: schedule.schedDetails,
                            );
                            
                          },
                        )),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  //schedule getter on date click
  void filterDate(String query){
    final filteredDates = scheduleList.where((schedule) {
      final dateTime = extractDatefromDTString(schedule.schedDateTime);
      print('dateTime $dateTime');
      final input = extractDatefromDTString(query);
      print("Input $input");
      return dateTime.contains(input); 

    }).toList();
    print(filteredDates);
    setState(() {
      schedules = filteredDates;
    });
  }

 
}
