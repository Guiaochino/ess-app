import 'dart:async';

import 'package:ess_app/guardian/widgets/patient_upcoming_reminder.dart';
import 'package:ess_app/guardian/widgets/patient_upcoming_schedule.dart';
import 'package:ess_app/guardian/widgets/upcoming_reminder.dart';
import 'package:ess_app/models/reminder_model.dart';
import 'package:ess_app/models/schedule_model.dart';
import 'package:ess_app/guardian/memory/memory_home_page.dart';
import 'package:ess_app/guardian/reminder/reminder_home.dart';
import 'package:ess_app/guardian/schedule/schedule_home.dart';
import 'package:ess_app/guardian/widgets/main_drawer.dart';
import 'package:ess_app/guardian/widgets/reminder_tab_listview.dart';
import 'package:ess_app/guardian/widgets/schedule_tab_listview.dart';
import 'package:ess_app/models/user_model.dart';
import 'package:ess_app/services/database.dart';
import 'package:ess_app/utils/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class patientHomePage extends StatefulWidget {
  const patientHomePage({super.key});

  @override
  State<patientHomePage> createState() => _patientHomePageState();
}

class _patientHomePageState extends State<patientHomePage> {

  List<ScheduleModel> schedules = [];
  List<ReminderModel> reminders = [];
  
  final dbconn = DatabaseService(uid: FirebaseAuth.instance.currentUser!.uid);
  late StreamSubscription<List<ReminderModel>> _reminderDataHomeSubscription;
  late StreamSubscription<List<ScheduleModel>> _scheduleDataHomeSubscription;

  @override
  void initState() {
    super.initState();
    _subscribeToStreams();
  }

  void _subscribeToStreams(){
    _reminderDataHomeSubscription = dbconn.reminderDataHome.listen((data) {
      setState(() {
        reminders = data;
      });
    });

    _scheduleDataHomeSubscription = dbconn.scheduleDataHome().listen((data) {
      setState(() {
        schedules = data;
      });
    });
  }
  @override
  void dispose() {
    _cancelSubscriptions();
    super.dispose();
  }

  void _cancelSubscriptions() {
    _reminderDataHomeSubscription.cancel();
    _scheduleDataHomeSubscription.cancel();
  }
 
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    final user = Provider.of<UserModel?>(context);

    if (user == null) {
      return Center(child: CircularProgressIndicator());
    }

    return WillPopScope(
      onWillPop:() async{
        return false;
      },
      child: Scaffold(
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
                        schedules.isEmpty? 
                        Center(
                          child: Column(
                            children: [
                              SizedBox(height: 20),
                              emptyCategory(
                                icon: Icons.event_busy,
                                detail: 'No Schedules Today',
                              ),
                              SizedBox(height: 20),
                            ],
                          ),
                        )
                        //listview builder of onclick date events
                        :ListView.builder(
                        shrinkWrap: true,
                        padding: EdgeInsets.zero,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: schedules.length,
                        itemBuilder: (context, index) {
                          final schedule = schedules[index];
                          return UpcomingScheduleListView(
                            tileIndex: index,
                            builderLength: schedules.length,
                            schedule: schedule,
                          );
                        },
                        )               
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
                        Center(
                          child: Column(
                            children: [
                              SizedBox(height: 20),
                              emptyCategory(
                                icon: Icons.event_busy,
                                detail: 'No Reminders Today',
                              ),
                              SizedBox(height: 20),
                            ],
                          ),
                        )
                        :Container(
                          child: ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: reminders.length,
                            itemBuilder: ((context, index) {
                              final reminder = reminders[index];
                              return UpcomingReminderListView(reminder: reminder);
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
      ),
    );
  }
}

class emptyCategory extends StatelessWidget {
  final IconData icon;
  final String detail;
  const emptyCategory({
    Key? key, required this.icon, required this.detail,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 40,
            color: Colors.black,
          ),
          Text(
            detail,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: Colors.grey[800],
              fontFamily: 'Montserrat',
            ),
          ),
        ],
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