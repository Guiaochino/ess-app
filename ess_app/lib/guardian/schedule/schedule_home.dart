import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:ess_app/constants.dart';
import 'package:ess_app/guardian/edit/edit_entry_schedule.dart';
import 'package:ess_app/guardian/widgets/popup_dialogs.dart';
import 'package:ess_app/models/schedule_model.dart';
import 'package:ess_app/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';
import 'package:table_calendar/table_calendar.dart';
import '../widgets/main_drawer.dart';
import '../widgets/schedule_tab_listview.dart';
import '../create/create_entry_schedule.dart';
import 'package:ess_app/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ScheduleHomePage extends StatefulWidget {
  const ScheduleHomePage({super.key});

  @override
  State<ScheduleHomePage> createState() => _ScheduleHomePageState();
}

class _ScheduleHomePageState extends State<ScheduleHomePage> {

  final dbconn = DatabaseService(uid: FirebaseAuth.instance.currentUser!.uid);
  DateTime dateClicked = DateTime.now();
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();
  CalendarFormat _calendarFormat = CalendarFormat.month;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return StreamBuilder<List<ScheduleModel>>(
      stream: dbconn.scheduleOfSelectedDate(_selectedDay),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<ScheduleModel> schedules = snapshot.data!;
          return Scaffold(
            appBar:AppBar(
              backgroundColor: AppColors.firstColor,
              foregroundColor: Colors.black,
              centerTitle: true,
              title: Text(
                'Schedule',
                style: TextStyle(
                  color: Colors.black, 
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1.0,
                  fontFamily: 'Montserrat'
                ),
              ), 
            ),
            drawer: MainDrawer(),
            floatingActionButton: FloatingActionButton.extended(
              backgroundColor: AppColors.firstColor,
              foregroundColor: Colors.black,
              label: Text('Add Schedule'),
              icon: Icon(Icons.add_box),
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => CreateEntrySchedule()));
              },
            ),
            body: Container(
              decoration: BoxDecoration(
                color: AppColors.backColor
              ),
              child: Column(
                children: [
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Container(
                      //table calendar
                      child: TableCalendar(
                        locale: 'en_US',
                        rowHeight: 50,
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
                            color: Colors.white,
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          weekendTextStyle: TextStyle(
                            color: Color.fromARGB(255, 218, 59, 48),
                            fontWeight: FontWeight.w500,
                            fontSize: 15,
                          ),
                          defaultDecoration: BoxDecoration(
                            color: Colors.white,
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
                            color: AppColors.firstColor.withOpacity(0.6),
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
                        //date selector 
                        onDaySelected: ((selectedDay, focusedDay) {
                          print(selectedDay);
                          setState(() {
                            _selectedDay = selectedDay;
                            _focusedDay = focusedDay;
                          });
                          dbconn.scheduleOfSelectedDate(_selectedDay);
                        }),
                      ),
                    ),
                  ),
                  //schedule tab
                  SizedBox(height: 10.0),
                  Expanded(
                    child: Container(
                      width: width ,
                      decoration: BoxDecoration(
                        color: AppColors.secondColor,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20.0),
                          topRight: Radius.circular(20.0),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(height: 15),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: Text(
                                    'Incoming Events',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 25,
                                      ),
                                  ),
                                ),
                                SizedBox(width: 10),
                                Text(
                                  DateFormat(' dd MMM yyyy').format(_selectedDay).toString(),
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 18,
                                    ),
                                ),
                              ],
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
                                          size: 100,
                                          color: Colors.white,
                                        ),
                                        Text(
                                          'No Schedule.',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              )
                              //listview builder of onclick date events
                              :ListView.builder(
                              shrinkWrap: true,
                              itemCount: schedules.length,
                              itemBuilder: (context, index) {
                                final schedule = schedules[index];
                                return ScheduleTabListView(
                                  tileIndex: index,
                                  builderLength: schedules.length,
                                  schedule: schedule,
                                  editTapped: (context){
                                    editScheduleEntry(context, schedule);
                                  },
                                  deleteTapped: (context) async {
                                    try {
                                      bool? deleteConfirmed = await showConfirmationDialog(context, 'Are you sure you want to delete?');
                                      if (deleteConfirmed == true) {
                                        // perform deletion
                                        await deleteScheduleEntry(scheduleCollection, schedule.uid);
                                      } else {
                                        // user canceled deletion
                                      }
                                    } catch (e) {
                                      // handle any errors that might occur here
                                      print(e);
                                    }
                                  
                                  }, 

                                );
                                
                              },
                            )),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else {
          return Text('Error: $snapshot.error');
        }
      },
    );
  }

  //schedule getter on date click
  // void filterDate(String query){
  //   final filteredDates = scheduleList.where((schedule) {
  //     final dateTime = extractDatefromDTString(schedule.schedDateTime);
  //     print('dateTime $dateTime');
  //     final input = extractDatefromDTString(query);
  //     print("Input $input");
  //     return dateTime.contains(input); 

  //   }).toList();
  //   print(filteredDates);
  //   setState(() {
  //     schedules = filteredDates;
  //   });
  // }

  
  Future <void> deleteScheduleEntry(String collectionCaller, String index) async{
    print('Deleted schedule at index ' + index.toString());
    dbconn.deleteKeyFromCollectionByID(collectionCaller, index);
    showDeletionSuccessDialog(context, 'Schedule deleted successfully!');

  }
  void editScheduleEntry(BuildContext context, ScheduleModel schedule) {
    Navigator.of(context).push(
      PageTransition(
        child: EditEntrySchedule(selectedSched: schedule),
        type: PageTransitionType.rightToLeft,
      ),
    );
  }
}
