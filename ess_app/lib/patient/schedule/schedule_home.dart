import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:ess_app/dataList/schedules.dart';
import 'package:ess_app/patient/create/create_entry_schedule.dart';
import 'package:ess_app/patient/edit/edit_entry_schedule.dart';
import 'package:ess_app/patient/widgets/main_drawer.dart';
import 'package:ess_app/patient/widgets/schedule_tab_listview.dart';
import 'package:ess_app/utils/colors.dart';
import 'package:ess_app/utils/dateTime_formatter.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class ScheduleHomePage extends StatefulWidget {
  const ScheduleHomePage({super.key});

  @override
  State<ScheduleHomePage> createState() => _ScheduleHomePageState();
}

class _ScheduleHomePageState extends State<ScheduleHomePage> {
  //schedule from datalist
  List<Schedule> schedules = scheduleList;
  DateTime dateClicked = DateTime.now();
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();
  CalendarFormat _calendarFormat = CalendarFormat.month;

  @override
  //filter dates onload
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

  @override
  Widget build(BuildContext context) {
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
            SizedBox(height: 20),
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
                  //date selector 
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
                child: Column(
                  children: [
                    Container(
                      height: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: Text(
                          'Schedule',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 25),
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
                                    size: 150,
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
                        //listview builder of onclick date events
                        :ListView.builder(
                        shrinkWrap: true,
                        itemCount: schedules.length,
                        itemBuilder: (context, index) {
                          final schedule = schedules[index];
                          return ScheduleTabListView(
                            tileIndex: index,
                            builderLength: schedules.length,
                            entryID: schedule.schedID,
                            title: schedule.schedTitle,
                            dateTime: schedule.schedDateTime,
                            details: schedule.schedDetails,
                            isDone: schedule.schedIsDone,
                            editTapped: (context){
                              editScheduleEntry(context, index);
                            },
                            deleteTapped: (context){
                              deleteScheduleEntry(index);
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
  // delete? yes or no
  AwesomeDialog deleteDialog(BuildContext context, int index) {
    return AwesomeDialog(
      context: context,
      dialogType: DialogType.QUESTION,
      borderSide: BorderSide(
        color: AppColors.secondColor,
        width: 2,
      ),
      width: MediaQuery.of(context).size.width * 0.9,
      buttonsBorderRadius: BorderRadius.all(Radius.circular(2)),
      dismissOnTouchOutside: true,
      dismissOnBackKeyPress: false,
      headerAnimationLoop: false,
      animType: AnimType.SCALE,
      title: 'Delete Entry?',
      titleTextStyle: TextStyle(
        overflow: TextOverflow.ellipsis,
        color: Colors.green,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
      desc: 'Are you sure you want to delete this diary entry?',
      btnOkText: 'Yes',
      btnOkColor: Color(0xFFE86166),
      btnCancelColor: Colors.blue,
      btnCancelText: 'No',
      btnOkOnPress: () {
        print('yes');
      },
      btnCancelOnPress: () {
        print('no');
      },
      padding: EdgeInsets.all(15),
      showCloseIcon: false,
    );
  }

  //delete successfully
  AwesomeDialog deleteSuccessDialog(BuildContext context) {
    return AwesomeDialog(
      context: context,
      dialogType: DialogType.SUCCES,
      borderSide: BorderSide(
        color: Colors.green,
        width: 2,
      ),
      width: MediaQuery.of(context).size.width * 0.9,
      buttonsBorderRadius: BorderRadius.all(Radius.circular(2)), 
      dismissOnTouchOutside: true,
      dismissOnBackKeyPress: false,
      headerAnimationLoop: false,
      animType: AnimType.SCALE,
      title: 'Deleted Successfully',
      titleTextStyle: TextStyle(
        overflow: TextOverflow.ellipsis,
        color: Colors.green,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
      onDissmissCallback:(type) {
        // Navigator.of(context).pop();
        
      },
      padding: EdgeInsets.all(15),
      showCloseIcon: false,
      autoHide: Duration(seconds: 3),
    );
  }
  void deleteScheduleEntry(int index) {

      print('Deleted diary at index ' + index.toString());
      setState(() {
        scheduleList.removeAt(index);
      });
      deleteSuccessDialog(context).show();
  }
  void editScheduleEntry(BuildContext context, int index) {
      Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => EditEntrySchedule(editIndex: index)));
  }
}
