import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../dataList/memories.dart';
import '../../widgets/main_drawer.dart';
import '../../widgets/memory_card.dart';
import '../../widgets/upcoming_schedule.dart';
import '../memory/memory_home_page.dart';
import '../reminder/reminder_home.dart';
import '../schedule/schedule_home.dart';

class guardianHomePage extends StatefulWidget {
  const guardianHomePage({Key? key}) : super(key: key);

  @override
  State<guardianHomePage> createState() => _guardianHomePageState();
}

class _guardianHomePageState extends State<guardianHomePage> {
  List<Memory> memories = memoryList;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            iconTheme: IconThemeData(color: Colors.black),
            backgroundColor: Color(0xFFF2BA05),
            elevation: 0,
            expandedHeight: 200,
            floating: false,
            pinned: true,
            centerTitle: false,
            title: Text(
              'Dashboard',
              style: TextStyle(
                color: Colors.black, 
                fontWeight: FontWeight.w700,
                fontSize: 25.0,
                letterSpacing: 2.0
              ),
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: Expanded(
                child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color.fromARGB(255, 238, 200, 76),
                          Color(0xFFF2BA05),
                        ],
                        stops: [
                          0.20,
                          1,
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                    child: ListView(
                      children: [
                        //items in flexappbar
                        SizedBox(
                          height: 60.0,
                        ),
                        //full container of hello guardian and icon
                        Container(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20.0),
                            // child: ListTile(
                            //   title: Padding(
                            //     child: Text(
                            //       'Hello and Welcome,',
                            //       // DateFormat.yMMMEd()
                            //       //     .format(DateTime.now())
                            //       //     .toString(),
                            //       style: TextStyle(
                            //           fontSize: 20,
                            //           fontWeight: FontWeight.bold,
                            //           color: Colors.grey[800]),
                            //     ),
                            //   ),
                            //   subtitle: Text(
                            //     'Chino Tiamzon',
                            //     style: TextStyle(
                            //         fontWeight: FontWeight.w900,
                            //         fontSize: 30,
                            //         letterSpacing: 4,
                            //         color: Colors.white),
                            //   ),
                            // ),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 3,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                                    child: Container(
                                        child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          DateFormat.yMMMEd().format(DateTime.now()).toString(),
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.grey[800]),
                                        ),
                                        SizedBox(height: 5.0),
                                        Text(
                                          'Hello, GuardianName',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w900,
                                              fontSize: 25,
                                              letterSpacing: 2,
                                              color: Colors.black),
                                        ),
                                      ],
                                    )),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    child: Icon(
                                      Icons.account_circle_rounded,
                                      size: 55,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ],
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
              padding: const EdgeInsets.only(top: 30.0),
              child: Container(
                height: 120,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal:20.0),
                  child: Row(
                    children: [
                      //memories button
                    Expanded(
                      flex: 1,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => MemoryHomePage()));
                        },
                        child: Container(
                          padding: EdgeInsets.all(15.0),
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
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Icon(Icons.photo_album_outlined,
                                  size: 50, color: Colors.white),
                              Text(
                                "Memories",
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                    color: Colors.white),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 10.0),
                    //schedules button
                    Expanded(
                      flex: 1,
                      child: GestureDetector(
                        onTap: () {
                        //schedule
                      },
                        child: Container(
                          padding: EdgeInsets.all(15.0),
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
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Icon(Icons.calendar_month_outlined,
                                  size: 50, color: Colors.white),
                              Text(
                                "Schedules",
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                    color: Colors.white),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 10.0),
                    //reminders button
                    Expanded(
                      flex:1,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => ReminderHomePage()));
                        },
                        child: Container(
                          padding: EdgeInsets.all(15.0),
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
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Icon(Icons.pending_actions_outlined,
                                  size: 50, color: Colors.white),
                              Text(
                                "Reminders",
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  color: Colors.white,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Expanded(
              child: Container(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    children: [
                      SizedBox(height: 30),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "OVERVIEW",
                          style: TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 20,
                              color: Colors.black),
                        ),
                      ),
                      SizedBox(height: 20.0),
                      Row(
                        children: [
                          Expanded(
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
                                    Text(
                                      'Image Memories',
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.grey[800]),
                                    ),
                                    Text(
                                      '0',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w900,
                                        fontSize: 25,
                                        color: Colors.black
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 10.0),
                          Expanded(
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
                                    Text(
                                      'Diary Memories',
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.grey[800]),
                                    ),
                                    Text(
                                      '0',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w900,
                                        fontSize: 25,
                                        color: Colors.black
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(
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
                                    Text(
                                      'Schedules',
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.grey[800]),
                                    ),
                                    Text(
                                      '0',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w900,
                                        fontSize: 25,
                                        color: Colors.black
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 10.0),
                          Expanded(
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
                                    Text(
                                      'Reminders',
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.grey[800]),
                                    ),
                                    Text(
                                      '0',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w900,
                                        fontSize: 25,
                                        color: Colors.black
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
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
              height: 280,
              child: Column(
                children: [
                  SizedBox(height: 30.0),
                  //title
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            'MOST RECENT MEMORIES',
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontWeight: FontWeight.w800, fontSize: 20),
                          ),
                        ),
                        Container(
                          child: MaterialButton(
                            color: Color(0xFFF2BA05),
                            highlightColor: Color(0xFFE86166),
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => MemoryHomePage()));
                            },
                            child: Text(
                              'View all',
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Expanded(
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 3,
                      itemBuilder: ((context, index) {
                        final memory = memories[index];
                        return MemoryCard(
                          title: memory.memoryTitle,
                          details: memory.memoryDetails,
                          imageDirectory: memory.memoryImg,
                          dateTime: memory.memoryDateTime,
                        );
                      }),
                    )
                  ),
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
                  SizedBox(height: 30.0),
                  //title
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal:20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            "UPCOMING SCHEDULES",
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontWeight: FontWeight.w800, fontSize: 20),
                          ),
                        ),
                        Container(
                          child: MaterialButton(
                            color: Color(0xFFF2BA05),
                            highlightColor: Color(0xFFE86166),
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => MemoryHomePage()));
                            },
                            child: Text(
                              'View all',
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
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
                          scheduleDate: "December 7 , 2022",
                          scheduleDetails: "Breakfast with you hehe",
                          scheduleTime: "07:00",
                        ),
                        SizedBox(height: 10.0),
                        UpSchedCard(
                          scheduleDate: "December 8 , 2022",
                          scheduleDetails: "Lunch with you hehe",
                          scheduleTime: "12:00",
                        ),
                        SizedBox(height: 10.0),
                        UpSchedCard(
                          scheduleDate: "December 12 , 2022",
                          scheduleDetails: "Dinner with you hehe",
                          scheduleTime: "18:00",
                        ),
                      ],
                    )),
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
                  SizedBox(height: 30),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Row(
                      //title
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            "YOUR REMINDERS",
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontWeight: FontWeight.w800, fontSize: 20),
                          ),
                        ),
                        Container(
                          child: MaterialButton(
                            color: Color(0xFFF2BA05),
                            highlightColor: Color(0xFFE86166),
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => MemoryHomePage()));
                            },
                            child: Text(
                              'View all',
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      children: [
                    //upcoming tile
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => ReminderHomePage()));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.white
                        ),
                        child: ListTile(
                        leading: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.event_note,
                              size: 40,
                              color: Color(0xFFE86166),
                            ),
                          ],
                        ),
                        title: Padding(
                          padding: const EdgeInsets.only(top: 10.0, bottom: 3.0),
                          child: Text(
                            "UPCOMING",
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 20,
                              color: Color(0xFFE86166),
                            ),
                          ),
                        ),
                        subtitle: Padding(
                          padding: const EdgeInsets.only(bottom: 10.0),
                          child: Text(
                            "4 Tasks",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 15,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        trailing: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.arrow_forward_ios,
                              size: 30,
                              color: Color(0xFFE86166),
                            ),
                          ],
                        ),
                      ),
                      ),
                    ),
                    SizedBox(height: 10.0),
                    //completed tile
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => ReminderHomePage()));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.white
                        ),
                        child: ListTile(
                        leading: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.event_available,
                              size: 40,
                              color: Color(0xFFE86166),
                            ),
                          ],
                        ),
                        title: Padding(
                          padding: const EdgeInsets.only(top: 10.0, bottom: 3.0),
                          child: Text(
                            "COMPLETED",
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 20,
                              color: Color(0xFFE86166),
                            ),
                          ),
                        ),
                        subtitle: Padding(
                          padding: const EdgeInsets.only(bottom: 10.0),
                          // task number text
                          child: Text(
                            "15 Tasks",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 15,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        trailing: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.arrow_forward_ios,
                              size: 30,
                              color: Color(0xFFE86166),
                            ),
                          ],
                        ),
                      ),
                      ),
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
