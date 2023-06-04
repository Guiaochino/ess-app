import 'dart:async';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:ess_app/guardian/create/create_entry_diary.dart';
import 'package:ess_app/guardian/create/create_entry_image.dart';
import 'package:ess_app/guardian/create/create_entry_reminder.dart';
import 'package:ess_app/guardian/create/create_entry_schedule.dart';
import 'package:ess_app/guardian/settings/how_to_use/how_to_use_home.dart';
import 'package:ess_app/guardian/view/view_entry_image.dart';
import 'package:ess_app/guardian/widgets/patient_upcoming_reminder.dart';
import 'package:ess_app/guardian/widgets/patient_upcoming_schedule.dart';
import 'package:ess_app/models/memory_model.dart';
import 'package:ess_app/models/reminder_model.dart';
import 'package:ess_app/models/schedule_model.dart';
import 'package:ess_app/guardian/memory/memory_home_page.dart';
import 'package:ess_app/guardian/reminder/reminder_home.dart';
import 'package:ess_app/guardian/schedule/schedule_home.dart';
import 'package:ess_app/guardian/widgets/main_drawer.dart';
import 'package:ess_app/models/user_model.dart';
import 'package:ess_app/services/database.dart';
import 'package:ess_app/utils/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';

class patientHomePage extends StatefulWidget {
  const patientHomePage({super.key});

  @override
  State<patientHomePage> createState() => _patientHomePageState();
}

class _patientHomePageState extends State<patientHomePage> {

  List<ScheduleModel> schedules = [];
  List<ReminderModel> reminders = [];
  UserModel user = UserModel(uid: '', email: '');
  
  final dbconn = DatabaseService(uid: FirebaseAuth.instance.currentUser!.uid);
  late StreamSubscription<List<ReminderModel>> _reminderDataHomeSubscription;
  late StreamSubscription<List<ScheduleModel>> _scheduleDataHomeSubscription;
  late StreamSubscription<UserModel> _userStream;
  MemoryModel sampleData  = MemoryModel(
    uid: '12312',
    memoryTitle: 'No data',
    memoryImg: 'https://firebasestorage.googleapis.com/v0/b/ess-back.appspot.com/o/images%2F36423?alt=media&token=eca6a10e-def8-4149-97ab-9de9e7f5d7b8',
    memoryDateTime: DateTime.now(),
    memoryDetails: 'Testasdasdasasda',
  );

  @override
  void initState() {
    super.initState();
    _subscribeToStreams();
    dbconn.fetchMemoryEntry().then((entry) {
      print('theres a fetched data');
      setState(() {
        sampleData = entry;
      });
    });
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

    _userStream = dbconn.userData.listen((data) {
      setState(() {
        user = data;
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
    _userStream.cancel();
  }
 
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

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
        drawer: MainDrawer(currentPage: 0,),
        floatingActionButton: SpeedDial(
          animatedIcon: AnimatedIcons.menu_close,
          backgroundColor: Color.fromARGB(255, 255, 197, 6),
          foregroundColor: Colors.black,
          overlayColor: Colors.black,
          overlayOpacity: 0.5,
          spacing: 12,
          switchLabelPosition: false,
          children: [
            SpeedDialChild(
              child: Icon(
                Icons.add_a_photo,
                color: Colors.white,
              ),
              label: 'Add Image',
              backgroundColor: Colors.grey[800],
              onTap: () {
                Navigator.of(context).push(
                  PageTransition(
                    child: CreateEntryImage(),
                    type: PageTransitionType.rightToLeft,
                  ),
                );
              },
            ),
            SpeedDialChild(
              child: Icon(Icons.note_add, 
                color: Colors.white,
              ),
              label: 'Add Diary',
              backgroundColor: Colors.grey[800],
              onTap: () {
                Navigator.of(context).push(
                  PageTransition(
                    child: CreateEntryDiary(),
                    type: PageTransitionType.rightToLeft,
                  ),
                );
              },
            ),
            SpeedDialChild(
              child: Icon(Icons.notification_add, 
                color: Colors.white,
              ),
              label: 'Add Reminder',
              backgroundColor: Colors.grey[800],
              onTap: () {
                Navigator.of(context).push(
                  PageTransition(
                    child: CreateEntryReminder(),
                    type: PageTransitionType.rightToLeft,
                  ),
                );
              },
            ),
            SpeedDialChild(
              child: Icon(Icons.add_box, 
                color: Colors.white,
              ),
              label: 'Add Schedule',
              backgroundColor: Colors.grey[800],
              onTap: () {
                Navigator.of(context).push(
                  PageTransition(
                    child: CreateEntrySchedule(),
                    type: PageTransitionType.rightToLeft,
                  ),
                );
              },
            )
          ],
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 30),
                TopBar(user: user),
                SizedBox(height: 40),
                Container(
                  height: 120,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal:20.0),
                    child: Row(
                      children: [
                        //memories button
                        mainButtons(
                          pageRedirect: () {                
                            Navigator.of(context).push(
                              PageTransition(
                                child: MemoryHomePage(activePage: 0),
                                type: PageTransitionType.rightToLeft,
                              ),
                            );
                          },
                          imgAsset: 'assets/images/memory.jpg',
                          title: 'Memories',
                        ),
                        SizedBox(width: 10.0),
                        //schedules button
                        mainButtons(
                          pageRedirect: () {
                            Navigator.of(context).push(
                              PageTransition(
                                child: ScheduleHomePage(),
                                type: PageTransitionType.rightToLeft,
                              ),
                            );
                          },
                          imgAsset: 'assets/images/schedule.jpg',
                          title: 'Schedules',
                        ),
                        SizedBox(width: 10.0),
                        //reminders button
                        mainButtons(
                          pageRedirect: () {
                            Navigator.of(context).push(
                              PageTransition(
                                child: ReminderHomePage(activePage: 0),
                                type: PageTransitionType.rightToLeft,
                              ),
                            );
                          },
                          imgAsset: 'assets/images/reminder.jpg',
                          title: 'Reminders',
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Container(
                    width: width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                            "Your Memory of the Day",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 20,
                              fontFamily: 'Montserrat',
                              color: Colors.black
                            ),
                          ),
                          SizedBox(height: 10),
                          sampleData.memoryTitle != 'Test Title' ?
                            MemoryCard(memory: sampleData):
                            Center(
                              child: Column(
                                children: [
                                  SizedBox(height: 20),
                                  emptyCategory(
                                    icon: Icons.photo,
                                    detail: 'No Memories. Yet',
                                  ),
                                  SizedBox(height: 20),
                                ],
                              ),
                            ) 
                      ],
                    ),
                  ),
                ),

                SizedBox(height: 30),
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
                        SizedBox(height: 20),     
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
                SizedBox(height: 30),
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
                      SizedBox(height: 20),
                      Expanded(
                        child: reminders.isEmpty?
                        Center(
                          child: Column(
                            children: [
                              SizedBox(height: 20),
                              emptyCategory(
                                icon: Icons.notifications_off,
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

class TopBar extends StatelessWidget {
  const TopBar({
    Key? key,
    required this.user,
  }) : super(key: key);

  final UserModel user;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(30),
            bottomLeft: Radius.circular(30),
            bottomRight: Radius.circular(30),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AnimatedTextKit(
                  totalRepeatCount: 1,
                  animatedTexts: [
                    TyperAnimatedText(
                      'Good day,',
                      textStyle: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Montserrat',
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 5),
                Text(
                  '${user.patientName}!',
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'Montserrat',
                    color: Colors.black,
                  ),
                ),
              
              ],
            ),
            Spacer(),
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  PageTransition(
                    child: HowToUseHome(),
                    type: PageTransitionType.rightToLeft,
                  ),
                );
              },
              child: Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [
                      Color(0xFFE86166),
                      Color(0xFFF2BA05),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Icon(
                  Icons.info_outline,
                  size: 30,
                  color: Colors.white,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class MemoryCard extends StatelessWidget {
  final MemoryModel memory;

  const MemoryCard({
    required this.memory,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      margin: EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Stack(
          children: [
            ColorFiltered(
              colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.3), BlendMode.darken),
              child: Image.network(
                memory.memoryImg,
                fit: BoxFit.cover,
                width: double.infinity,
                height: 200,
              ),
            ),
            Container(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    memory.memoryTitle,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Spacer(),
                  Text(
                    memory.memoryDetails,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Icon(
                        Icons.calendar_today,
                        size: 14,
                        color: Colors.white,
                      ),
                      SizedBox(width: 4),
                      Text(
                        DateFormat('MMM d, yyyy').format(memory.memoryDateTime),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                      Spacer(),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            PageTransition(
                              child: ViewEntryImage(
                                memory: memory,
                              ),
                              type: PageTransitionType.bottomToTop,
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Color(0xFFE86166),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Text(
                          'Read More',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
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
            size: 100,
            color: Colors.black,
          ),
          Text(
            detail,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: TextStyle(
              fontSize: 20,
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