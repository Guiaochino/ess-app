import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

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

//   @override
//   void initState() {
//     // if no current sched, then 1st time ever opening the app
//     //create default data
//     if (_myBox.get("CURRENT_SCHEDULE_LIST") == null) {
//       db.createDefaultData();
//       print("no saved data");
//     }
//     //if theres an existing data, load it
//     else {
//       db.loadData();
//       print(db.ScheduleList);
//     }
//     super.initState();
//   }

//   // firstDate
//   DateTime FirstDate() {
//     DateTime fetchedDate;
//     DateTime firstDate = DateTime.now();
//     print(db.ScheduleList);
//     for (var i = 0; i < db.ScheduleList.length; i++) {
//       fetchedDate = parseStringToDate(db.ScheduleList[i][3]);
//       if (fetchedDate.isBefore(firstDate)) {
//         firstDate = fetchedDate;
//         print('$fetchedDate aaaaaaa');
//       }
//     }
//     print('first date is, $firstDate');
//     return firstDate;
//   }

//   //clicked date events getter
//   List showClickedDateEvents(DateTime clickedDate) {
//     List thisDaySchedule = [];
//     for (var i = 0; i < db.ScheduleList.length; i++) {
//       DateTime fetchedDate = parseStringToDate(db.ScheduleList[i][3]);
//       if (fetchedDate.difference(clickedDate).inDays == 0) {
//         thisDaySchedule.add(db.ScheduleList[i]);
//       }
//     }
//     return thisDaySchedule;
//   }

//event done controller
  bool eventDone = false;
//checkbox tapper
  // void checkBoxTapped(bool? value, int index) {
  //   setState(() {
  //     db.ScheduleList[index][2] = value!;
  //   });
  //   db.updateDataBase();
  // }

// //delete schedule
//   void deleteSchedule(int index) {
//     setState(() {
//       db.ScheduleList.removeAt(index);
//       db.updateDataBase();
//     });
//   }

  List ScheduleList = [
      //datetime format is dd-mm-yyyy hh:mm:ss
      [
        'sched 1',
        '2Sit sint mollit enim cillum exercitation officia est pariatur. Proident ex id eu nostrud laborum incididunt ad sit est. Minim adipisicing nostrud enim consectetur. Veniam consectetur officia veniam est elit ullamco. Sunt ut ullamco magna incididunt dolor deserunt dolore eu duis enim. Eiusmod pariatur fugiat do veniam.',
        false,
        '13-12-2022 23:58:44',
      ],
      [
        'sched 2',
        '1Sit sint mollit enim cillum exercitation officia est pariatur. Proident ex id eu nostrud laborum incididunt ad sit est. Minim adipisicing nostrud enim consectetur. Veniam consectetur officia veniam est elit ullamco. Sunt ut ullamco magna incididunt dolor deserunt dolore eu duis enim. Eiusmod pariatur fugiat do veniam.',
        false,
        '22-09-2022 12:39:20',
      ],
      [
        'sched 3',
        '3Sit sint mollit enim cillum exercitation officia est pariatur. Proident ex id eu nostrud laborum incididunt ad sit est. Minim adipisicing nostrud enim consectetur. Veniam consectetur officia veniam est elit ullamco. Sunt ut ullamco magna incididunt dolor deserunt dolore eu duis enim. Eiusmod pariatur fugiat do veniam.',
        false,
        '12-06-2022 23:23:44',
      ],
      [
        'sched 4',
        '4Sit sint mollit enim cillum exercitation officia est pariatur. Proident ex id eu nostrud laborum incididunt ad sit est. Minim adipisicing nostrud enim consectetur. Veniam consectetur officia veniam est elit ullamco. Sunt ut ullamco magna incididunt dolor deserunt dolore eu duis enim. Eiusmod pariatur fugiat do veniam.',
        false,
        '12-25-2020 12:58:44',
      ],
    ];
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
            Expanded(flex: 1, child: MonthlySummary()),
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: [
                      Container(
                        height: 60,
                        decoration: BoxDecoration(
                          color: Color(0xFFE86166),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Center(
                          child: Text(
                            'SCHEDULES',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w800,
                                fontSize: 30),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Expanded(
                        child: Container(
                            child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: 4,
                          itemBuilder: (context, index) {
                            return ScheduleTabListView();
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
}
