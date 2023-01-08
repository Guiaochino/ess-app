import 'package:ess_app/guardian/view/view_entry_schedule.dart';
import 'package:ess_app/utils/dateTime_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ScheduleTabListView extends StatelessWidget {
  final int entryID;
  final String title;
  final String details;
  final String dateTime;
  final bool isDone;
  final Function(BuildContext)? deleteTapped;
  final Function(BuildContext)? editTapped;

  ScheduleTabListView({
    super.key,
    required this.entryID,
    required this.title,
    required this.details,
    required this.dateTime,
    required this.isDone,
    required this.deleteTapped,
    required this.editTapped,

  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Slidable(
        // no edit button if sched is done
         startActionPane: isDone == true ? null
         :ActionPane(
          motion: DrawerMotion(),
          children: [
            SlidableAction(
              onPressed: editTapped,
              backgroundColor: Colors.blue,
              icon: Icons.edit_note,
              label: 'Edit',
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20),
                  bottomRight: Radius.circular(20)),
            )
          ],
        ),
        endActionPane: ActionPane(
          motion: DrawerMotion(),
          children: [
            SlidableAction(
              onPressed: deleteTapped,
              icon: Icons.delete_forever,
              label: 'Delete',
              backgroundColor: Colors.red,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  bottomLeft: Radius.circular(20)),
            )
          ],
        ),
        child: Container(
          height: 100,
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(15),
          ),
          child: Center(
            child: ListTile(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => ViewEntrySchedule(
                    entryIndex: entryID,
                    title: title,
                    dateTime: dateTime,
                    isDone: isDone,
                    details: details,
                  )));
              },
              leading: Icon(
                Icons.schedule,
                size: 50,
                color: Colors.black,
              ),
              title: Text(
                title,
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w900,
                  fontSize: 25,
                  ),
                ),
              subtitle: Text(
                extractTimefromDTString(dateTime),
                style: TextStyle(
                  color: Colors.grey[600],
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              trailing: Icon(
                Icons.arrow_forward_ios,
                size: 30,
              ),
              contentPadding: EdgeInsets.symmetric(horizontal: 20),
            ),
          ),
        ),
      ),
    );
  }
}
// child: Column(
//                 children: [
//                   //1st column - icon and title
//                   Container(
//                     height: 50,
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Expanded(
//                           child: Container(
//                             child: Row(
//                               children: [
//                                 Container(
//                                   child: Align(
//                                     alignment: Alignment.center,
//                                     child: Text(
//                                       TimeOfDay.now()
//                                           .format(context)
//                                           .toString(),
//                                       overflow: TextOverflow.ellipsis,
//                                       style: TextStyle(
//                                           fontSize: 25,
//                                           fontWeight: FontWeight.w600),
//                                     ),
//                                   ),
//                                 ),
//                                 Padding(
//                                   padding: const EdgeInsets.symmetric(
//                                       horizontal: 10.0, vertical: 5.0),
//                                   child: Container(
//                                     width: 5,
//                                     height: 50,
//                                     color: Colors.black,
//                                   ),
//                                 ),
//                                 Expanded(
//                                   child: Container(
//                                     child: Align(
//                                       alignment: Alignment.centerLeft,
//                                       child: Text(
//                                         "sampleTitle",
//                                         overflow: TextOverflow.ellipsis,
//                                         style: TextStyle(
//                                             fontSize: 25,
//                                             fontWeight: FontWeight.w600),
//                                       ),
//                                     ),
//                                   ),
//                                 )
//                               ],
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
                  
//                 ],
//               ),