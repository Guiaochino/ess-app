import 'package:ess_app/dataList/reminders.dart';
import 'package:ess_app/dataList/schedules.dart';
import 'package:ess_app/patient/memory/memory_home_page.dart';
import 'package:ess_app/patient/reminder/reminder_home.dart';
import 'package:ess_app/patient/schedule/schedule_home.dart';
import 'package:ess_app/patient/widgets/main_drawer.dart';
import 'package:ess_app/patient/widgets/reminder_tab_listview.dart';
import 'package:ess_app/patient/widgets/schedule_tab_listview.dart';
import 'package:ess_app/utils/colors.dart';
import 'package:ess_app/utils/dateTime_formatter.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:intl/intl.dart';

class patientHomePage extends StatefulWidget {
  const patientHomePage({super.key});

  @override
  State<patientHomePage> createState() => _patientHomePageState();
}

class _patientHomePageState extends State<patientHomePage> {
  List<Reminder> reminders = reminderList.where((i) => i.reminderIsDone == false).toList();
  List<Schedule> schedules = scheduleList;
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
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppColors.backColor,
      appBar: AppBar(
        foregroundColor: Colors.black,
        backgroundColor: AppColors.firstColor,
        centerTitle: true,
        title: Text(
          DateFormat.MMMMEEEEd().format(DateTime.now()).toString(),
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 15,
            fontFamily: 'Montserrat',
            color: Colors.black
          ),
        ),
      ),
      drawer: MainDrawer(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //appbar
              // Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: 20.0),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //     children: [
              //       Text(
              //         'Hello, Akachiii',
              //         style: TextStyle(
              //           fontWeight: FontWeight.w600,
              //           fontSize: 18,
              //           fontFamily: 'Montserrat',
              //           color: Colors.black
              //         ),
              //       ),
              //       Container(
              //         height: 50,
              //         width: 50,
              //         decoration: BoxDecoration(
              //           color: AppColors.secondColor.withOpacity(0.1),
              //           borderRadius: BorderRadius.all(Radius.circular(12)),
              //         ),
              //         child: Icon(
              //           Icons.person,
              //           size: 30,
              //           color: AppColors.secondColor, 
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              SizedBox(height: 20),
              Container(
                height: 120,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal:20.0),
                  child: Row(
                    children: [
                      //memories button
                      mainButtons(
                        pageRedirect: () {
                          Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => MemoryHomePage(activePage: 0,)));
                        }, 
                        imgAsset: 'assets/images/memory.jpg', 
                        title: 'Memories',
                      ),
                      SizedBox(width: 10.0),
                      //schedules button
                      mainButtons(
                        pageRedirect: () {
                          Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => ScheduleHomePage()));
                        }, 
                        imgAsset: 'assets/images/schedule.jpg', 
                        title: 'Schedules',
                      ),
                      SizedBox(width: 10.0),
                      //reminders button
                    mainButtons(
                        pageRedirect: () {
                          Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => ReminderHomePage(activePage: 0,)));
                        }, 
                        imgAsset: 'assets/images/reminder.jpg', 
                        title: 'Reminders',
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              //datetimeline
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Container(
                  width: width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Today's Events",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                          fontFamily: 'Montserrat',
                          color: Colors.black
                        ),
                      ),
                      SizedBox(height: 10),     
                      Container(
                        decoration: BoxDecoration(
                          color: AppColors.secondColor,
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                        ),
                        child: schedules.isEmpty? 
                        Center(
                          child: Column(
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
                                      size: 70,
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
                              SizedBox(height: 20),
                            ],
                          ),
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
                            },
                            deleteTapped: (context){
                            }, 
                          );
                        },
                      ))               
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              Container(
                height: 400,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Text(
                        'Upcoming Reminders',
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontWeight: FontWeight.w600, 
                          fontSize: 20,
                          fontFamily: 'Montserrat',
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Expanded(
                      child: reminders.isEmpty?
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            child: Column(
                              children: [
                                Icon(
                                  Icons.notifications_off,
                                  size: 200,
                                  color: Colors.black,
                                ),
                                Text(
                                  'No Reminders',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 25),
                                ),
                              ],
                            ),
                          ),
                        ],
                      )
                      :Container(
                        child: ListView.builder(
                          itemCount: reminders.length,
                          itemBuilder: ((context, index) {
                            final reminder = reminders[index];
                            return ReminderTabListView(
                              reminderIndex: reminder.reminderID,
                              reminderTitle: reminder.reminderTitle,
                              reminderDateTime: reminder.reminderDateTime,
                              reminderDetails: reminder.reminderDetails,
                              isDone: reminder.reminderIsDone,
                              deleteTapped: (context){
                                // deleteDialog(context, index).show();
                                
                                print('tapped');
                              },
                              editTapped:(context){
                              }
                            );
                          }),
                        ),
                      ),
                    ),
        
                  ],
                ),
              )
              //scheds
              
              //reminders
              
              //listview of buttons
            ],
          ),
        ),
      ),
    );
  }
}

class mainButtons extends StatelessWidget {
  final Function()? pageRedirect;
  final String imgAsset;
  final String title;
  const mainButtons({
    Key? key, 
    required this.pageRedirect,
    required this.imgAsset, 
    required this.title,

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: GestureDetector(
        onTap: pageRedirect,
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              gradient: LinearGradient(
                colors: [
                  Color(0xFFE86166),
                  Color.fromARGB(255, 235, 113, 117),
                ],
                begin: Alignment.bottomLeft,
                end: Alignment.topRight,
              ),
            ),
          child: Stack(
            fit: StackFit.expand, 
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12), 
                  color: Colors.black
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Opacity(
                    opacity: 0.6,
                    child: Image.asset(
                      imgAsset,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Center(
                child: Text(
                  title,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Montserrat',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}