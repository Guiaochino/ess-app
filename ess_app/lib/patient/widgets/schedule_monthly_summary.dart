import 'package:flutter/material.dart';
import 'package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart';

class MonthlySummary extends StatefulWidget {
  const MonthlySummary({super.key});

  @override
  State<MonthlySummary> createState() => _MonthlySummaryState();
}

class _MonthlySummaryState extends State<MonthlySummary> {
//   ScheduleDatabase db = ScheduleDatabase();
//   final _myBox = Hive.box("Schedule_Database");
//   List thisDaySchedule = [];
//   DateTime clickedDate = DateTime.now();

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

//   //clicked date events getter
//   // showClickedDateEvents() {
//   //   List thisDaySchedule = [];
//   //   for (var i = 0; i < db.ScheduleList.length; i++) {
//   //     DateTime fetchedDate = parseStringToDate(db.ScheduleList[i][3]);
//   //     if (fetchedDate.difference(clickedDate).inDays == 0) {
//   //       thisDaySchedule.add(db.ScheduleList[i]);
//   //     }
//   //   }
//   //   print(thisDaySchedule);
//   // }

// //event done controller
//   bool eventDone = false;
// //checkbox tapper
//   void checkBoxTapped(bool? value, int index) {
//     setState(() {
//       db.ScheduleList[index][2] = value!;
//     });
//     db.updateDataBase();
//   }

// //delete schedule
//   void deleteSchedule(int index) {
//     setState(() {
//       db.ScheduleList.removeAt(index);
//       db.updateDataBase();
//     });
//   }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        child: HeatMapCalendar(
          initDate: DateTime.now(),
          datasets: {
            DateTime(2022, 12, 2): 3,
          },
          margin: EdgeInsets.all(5),
          colorMode: ColorMode.color,
          borderRadius: 10,
          defaultColor: Colors.grey[200],
          textColor: Colors.black,
          showColorTip: false,
          size: 40,
          monthFontSize: 20,
          weekFontSize: 14,
          weekTextColor: Colors.black,
          flexible: true,
          colorsets: const {
            1: Colors.red,
            2: Colors.lightBlue,
            3: Colors.orange,
            5: Colors.yellow,
            7: Colors.green,
            9: Colors.blue,
            11: Colors.indigo,
            13: Colors.purple,
          },
          onClick: (value) {
            
          },
        ),
      ),
    );
  }
}
// child: Column(
//           children: [
//             Expanded(
//                 child: Column(
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.symmetric(
//                       horizontal: 20.0, vertical: 20.0),
//                   child: Center(
//                     child: HeatMapCalendar(
//                       initDate: DateTime.now(),
//                       datasets: {
//                         DateTime(2022, 12, 2): 3,
//                       },
//                       margin: EdgeInsets.all(5),
//                       colorMode: ColorMode.color,
//                       borderRadius: 10,
//                       defaultColor: Colors.grey[200],
//                       textColor: Colors.black,
//                       showColorTip: false,
//                       size: 40,
//                       monthFontSize: 20,
//                       weekFontSize: 14,
//                       weekTextColor: Colors.black,
//                       flexible: true,
//                       colorsets: const {
//                         1: Colors.red,
//                         2: Colors.lightBlue,
//                         3: Colors.orange,
//                         5: Colors.yellow,
//                         7: Colors.green,
//                         9: Colors.blue,
//                         11: Colors.indigo,
//                         13: Colors.purple,
//                       },
//                       onClick: (value) {
//                         // clickedDate = value;
//                       },
//                     ),
//                   ),
//                 ),
//                 Container(
//                   height: 50,
//                   width: 50,
//                   // child: MaterialButton(
//                   //   onPressed: showClickedDateEvents,
//                   // ),
//                 ),
//                 // Expanded(
//                 //   flex: 4,
//                 //   child: Container(
//                 //       child: ListView.builder(
//                 //     shrinkWrap: true,
//                 //     itemCount: db.ScheduleList.length,
//                 //     itemBuilder: (context, index) {
//                 //       return ScheduleTabListView(
//                 //         scheduleTitle: showClickedDateEvents()[index][0],
//                 //         scheduleDetails: showClickedDateEvents()[index][1],
//                 //         eventDone: showClickedDateEvents()[index][2],
//                 //         scheduleDateTime: showClickedDateEvents()[index][3],
//                 //         onChanged: (value) {
//                 //           checkBoxTapped(value, index);
//                 //         },
//                 //         deleteTapped: (context) {
//                 //           deleteSchedule(index);
//                 //         },
//                 //       );
//                 //     },
//                 //   )),
//                 // ),
//               ],
//             )),
//           ],
//         ),