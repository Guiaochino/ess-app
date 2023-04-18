import 'package:ess_app/dataList/diaries.dart';
import 'package:ess_app/utils/colors.dart';
import 'package:ess_app/guardian/widgets/diary_card.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../dataList/memories.dart';
import '../widgets/main_drawer.dart';
import '../widgets/memory_card.dart';
import '../widgets/upcoming_schedule.dart';
import '../memory/memory_home_page.dart';
import '../reminder/reminder_home.dart';
import '../schedule/schedule_home.dart';

class guardianHomePage extends StatefulWidget {
  const guardianHomePage({Key? key}) : super(key: key);

  @override
  State<guardianHomePage> createState() => _guardianHomePageState();
}

class _guardianHomePageState extends State<guardianHomePage> {
  final _imagePageController = PageController();
  final _diaryPageController = PageController();

  List<Memory> memories = memoryList;
  List <Diary> diaries = diaryList;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(238, 238, 238, 1),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            iconTheme: IconThemeData(color: Colors.black),
            backgroundColor: Color(0xFFF2BA05),
            elevation: 0,
            expandedHeight: 150,
            floating: false,
            pinned: true,
            centerTitle: false,
            title: Text(
              'Dashboard',
              style: TextStyle(
                color: Colors.black, 
                fontWeight: FontWeight.w700,
                fontSize: 25.0,
                letterSpacing: 1.0,
                fontFamily: 'Montserrat'
              ),
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: Expanded(
                child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color.fromARGB(255, 238, 200, 76),
                          AppColors.firstColor,
                        ],
                        stops: [
                          0.20,
                          1,
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                    child: Column(
                      children: [
                        //items in flexappbar
                        SizedBox(
                          height: 40.0,
                        ),
                        //full container of hello guardian and icon
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Center(
                              child: Container(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          DateFormat.yMMMEd().format(DateTime.now()).toString(),
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w600,
                                            fontFamily: 'Montserrat',
                                            color: Colors.grey[800],
                                          ),
                                        ),
                                        Text(
                                          'Hi Mychal!',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 25,
                                            fontFamily: 'Montserrat',
                                            color: Colors.black
                                          ),
                                        ),
                                      ],
                                    ),
                                    Container(
                                      height: 60,
                                      width: 60,
                                      decoration: BoxDecoration(
                                        color: Color.fromARGB(255, 47, 92, 150).withOpacity(0.1),
                                        borderRadius: BorderRadius.all(Radius.circular(12)),
                                      ),
                                      child: Icon(
                                        Icons.person,
                                        size: 40,
                                        color: Colors.grey[800], 
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ),
              ),
            ),
          ),
          //categories
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Container(
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
            ),
          ),
          //overview
          SliverToBoxAdapter(
            child: Expanded(
              child: Container(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    children: [
                      SizedBox(height: 10),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Overview",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 20,
                            color: Colors.black,
                            fontFamily: 'Montserrat',
                          ),
                        ),
                      ),
                      SizedBox(height: 10.0),
                      Row(
                        children: [
                          statCard(
                            title: 'Images',
                            icon: Icons.photo,
                            iconColor: Color.fromARGB(255, 223, 171, 1),
                            statNum: 123,
                          ),
                          SizedBox(width: 10.0),
                          statCard(
                            title: 'Diaries',
                            icon: Icons.book_sharp,
                            iconColor: AppColors.secondColor,
                            statNum: 132,
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          statCard(
                            title: 'Schedules',
                            icon: Icons.calendar_month_outlined,
                            iconColor: Color.fromARGB(255, 47, 92, 150),
                            statNum: 425,
                          ),
                          SizedBox(width: 10.0),
                          statCard(
                            title: 'Reminders',
                            icon: Icons.notifications_active,
                            iconColor: Color.fromARGB(255, 145, 20, 167),
                            statNum: 425,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          //memories
          SliverToBoxAdapter(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              height: 320,
              child: Column(
                children: [
                  SizedBox(height: 20.0),
                  //title
                  categoryHeading(
                    title: 'Recent Memories', 
                    pageRedirect: () {
                      Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => MemoryHomePage(activePage: 0,)));
                    },
                  ),
                  SizedBox(height: 20.0),
                  Expanded(
                    child: Container(
                      height: MediaQuery.of(context).size.width - 40,
                      child: PageView.builder(
                        controller: _imagePageController,
                        itemCount: 3,
                        itemBuilder: ((context, index) {
                          final memory = memories[index];
                          return MemoryCard(
                            imageId: index,
                            title: memory.memoryTitle,
                            details: memory.memoryDetails,
                            imageDirectory: memory.memoryImg,
                            dateTime: memory.memoryDateTime,
                          );
                        }),
                      ),
                    ),
                  ),
                  SizedBox(height:10.0),
                  SmoothPageIndicator(
                    controller: _imagePageController, 
                    count: 3,
                    effect: ExpandingDotsEffect(activeDotColor: Color.fromARGB(255, 228, 175, 0)),
                    )
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              height: 320,
              child: Column(
                children: [
                  SizedBox(height: 20.0),
                  //title
                  categoryHeading(
                    title: 'Recent Diaries', 
                    pageRedirect: () {
                      Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => MemoryHomePage(activePage: 0,)));
                    },
                  ),
                  SizedBox(height: 20.0),
                  Expanded(
                    child: Container(
                      height: MediaQuery.of(context).size.width - 40,
                      child: PageView.builder(
                        controller: _diaryPageController,
                        itemCount: 3,
                        itemBuilder: ((context, index) {
                          final diary = diaries[index];
                          // return DiaryCard(
                          //   diaryId: diary.diaryID,
                          //   title: diary.diaryTitle,
                          //   details: diary.diaryDetails,
                          //   dateTime: diary.diaryDateTime, 
                          //   emoteRate: diary.emoteRate,
                          // );
                        }),
                      ),
                    ),
                  ),
                  SizedBox(height:10.0),
                  SmoothPageIndicator(
                    controller: _diaryPageController, 
                    count: 3,
                    effect: ExpandingDotsEffect(activeDotColor: Color.fromARGB(255, 228, 175, 0)),
                    )
                ],
              ),
            ),
          ),
          //UPCOMING SCHEDULE
          SliverToBoxAdapter(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  SizedBox(height: 20.0),
                  //title
                  categoryHeading(title: 'Upcoming Schedules', 
                    pageRedirect: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ScheduleHomePage()));
                    },
                  ),
                  SizedBox(height: 20.0),
                  //schedule cards
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                    child: Expanded(
                      child: Column(
                      children: [
                        //schedule cards, change function values to change inputs
                        UpSchedCard(
                          scheduleDate: "Dec 07 - Monday",
                          scheduleDetails: "Breakfast with you hehe",
                          scheduleTime: "07:00 AM",
                        ),
                        SizedBox(height: 10.0),
                        UpSchedCard(
                          scheduleDate: "Dec 08 - Tuesday",
                          scheduleDetails: "Lunch with you hehe",
                          scheduleTime: "12:00 PM",
                        ),
                        SizedBox(height: 10.0),
                        UpSchedCard(
                          scheduleDate: "Dec 12 - Saturday",
                          scheduleDetails: "Dinner with you hehe",
                          scheduleTime: "08:00 PM",
                        ),
                      ],
                    )
                    ),
                  )
                ],
              ),
            ),
          ),
          //YOURREMINDERS
          SliverToBoxAdapter(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              height: 300,
              child: Column(
                children: [
                  SizedBox(height: 20),
                  categoryHeading(
                    title: 'Daily Reminders',
                    pageRedirect: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ReminderHomePage(activePage: 0,)));
                    },
                  ),
                  SizedBox(height: 20.0),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      children: [
                        //upcoming tile
                        reminderTile(
                          title: 'Upcoming', 
                          badge: 5, 
                          icon: Icons.event_note,
                        ),
                        SizedBox(height: 10),
                        //completed tile
                        reminderTile(
                          title: 'Completed', 
                          badge: 12,
                          icon: Icons.event_available,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
      //drawer
      drawer: MainDrawer(),
    );
  }
}

class reminderTile extends StatelessWidget {
  final String title;
  final int badge;
  final IconData icon;
  const reminderTile({
    Key? key, required this.title, required this.badge, required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      height: 60,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 145, 20, 167).withOpacity(0.1),
                borderRadius: BorderRadius.all(Radius.circular(12)),
              ),
              child: Icon(
                icon,
                size: 30,
                color: Color.fromARGB(255, 145, 20, 167), 
              ),
            ),
            Text(
              title,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontFamily: 'Montserrat',
                fontSize: 20,
                color: Colors.black
              ),
            ),
            Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                color: AppColors.secondColor.withOpacity(0.1),
                borderRadius: BorderRadius.all(Radius.circular(12)),
              ),
              child: Center(
                child: Text(
                  badge.toString(),
                  style: TextStyle(
                  fontWeight: FontWeight.w800,
                  fontFamily: 'Montserrat',
                  fontSize: 20,
                  color: AppColors.secondColor 
                ),
                ),
              )
            ),
          ],
        ),
      ),
    );
  }
}

class categoryHeading extends StatelessWidget {
  final String title;
  final Function()? pageRedirect;
  const categoryHeading({
    Key? key, required this.title, required this.pageRedirect,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              title,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontWeight: FontWeight.w600, 
                fontSize: 20,
                fontFamily: 'Montserrat',
              ),
            ),
          ),
          Container(
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(AppColors.firstColor),
                overlayColor: MaterialStateProperty.all(Color.fromARGB(255, 230, 177, 5)),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  )
                )
              ),
              onPressed: pageRedirect,
              child: Text(
                'View all',
                textAlign: TextAlign.right,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 15,
                  color: Colors.black,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class statCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color iconColor;
  final int statNum;
  
  const statCard({
    Key? key, required this.title, required this.icon, required this.iconColor, required this.statNum,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    var width = MediaQuery.of(context).size.width;
    return Expanded(
      flex: 1,
      child: Container(
        height: 100,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12)
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(width: 10),
                  Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      color: iconColor.withOpacity(0.1),
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                    ),
                    child: Icon(
                      icon,
                      color: iconColor, 
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: width > 320? Text(
                      title,
                      overflow:TextOverflow.ellipsis,
                      maxLines: 1,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey[800],
                        fontFamily: 'Montserrat',
                      ),
                    ): Container(),
                  ),
                  SizedBox(width: 10),
                ],
              ),
              Text(
                statNum.toString(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 25,
                  color: Colors.black,
                  fontFamily: 'Montserrat',
                ),
              ),
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
