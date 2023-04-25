
import 'package:ess_app/guardian/view/view_entry_reminder.dart';
import 'package:ess_app/models/reminder_model.dart';
import 'package:ess_app/utils/dateTime_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ReminderTabListView extends StatelessWidget {
  final ReminderModel reminder;
  final Function(BuildContext)? deleteTapped;
  final Function(BuildContext)? editTapped;

  ReminderTabListView({
    required this.reminder,
    required this.deleteTapped,
    required this.editTapped, 
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Slidable(
        startActionPane: ActionPane(
          motion: DrawerMotion(),
          children: [
            SlidableAction(
              onPressed: editTapped,
              backgroundColor: Colors.blue,
              icon: Icons.edit_note,
              label: 'Edit',
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
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
                bottomLeft: Radius.circular(20),
              ),
            )
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: MaterialButton(
            onPressed: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => ViewReminder(
                        reminder: reminder,
                      )));
            },
            child: Container(
              height: 80,
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(15),
              ),
              child: Center(
                child: ListTile(
                   title: Text(
                    reminder.reminderTitle,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      decoration: reminder.reminderIsDone ? TextDecoration.lineThrough: TextDecoration.none,
                      color: reminder.reminderIsDone ? Colors.grey[800]:Colors.black,
                      fontWeight: FontWeight.w700,
                      fontSize: 20,
                      ),
                    ),
                  subtitle: Text(
                    reminder.reminderDetails,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      decoration: reminder.reminderIsDone ? TextDecoration.lineThrough: TextDecoration.none,
                      color: Colors.grey[600],
                      fontWeight: FontWeight.w500,
                      fontSize:15,
                    ),
                  ),
                  trailing: Text(
                    reminder.reminderDateTime.toString(),
                    maxLines: 1,
                    style: TextStyle(
                      color: Color(0xFFE86166),
                      fontWeight: FontWeight.w800,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
              
              // child: Center(
              //   child: Padding(
              //     padding: const EdgeInsets.all(10.0),
              //     child: Column(
              //       children: [
              //         //1st column - icon and title
              //         Container(
              //           height: 50,
              //           child: Row(
              //             children: [
              //               Icon(
              //                 Icons.drive_file_rename_outline,
              //                 size: 50,
              //               ),
              //               Padding(
              //                 padding: const EdgeInsets.symmetric(
              //                   horizontal: 20.0, 
              //                   vertical: 5.0,
              //                 ),
              //                 child: Container(
              //                   width: 5,
              //                   height: 50,
              //                   color: Colors.black,
              //                 ),
              //               ),
              //               Expanded(
              //                 child: Align(
              //                   alignment: Alignment.centerLeft,
              //                   child: Text(
              //                     reminderTitle,
              //                     overflow: TextOverflow.ellipsis,
              //                     style: TextStyle(
              //                       fontSize: 25, 
              //                       fontWeight: FontWeight.w600,
              //                     ),
              //                   ),
              //                 ),
              //               )
              //             ],
              //           ),
              //         ),
              //         //2nd Column -  diary details
              //         Expanded(
              //           child: Padding(
              //             padding: const EdgeInsets.symmetric(
              //               vertical: 10.0, 
              //               horizontal: 10.0
              //             ),
              //             child: Container(
              //               child: Container(
              //                 child: Text(
              //                   reminderDetails,
              //                   maxLines: 4,
              //                   overflow: TextOverflow.ellipsis,
              //                   textAlign: TextAlign.justify,
              //                   style: TextStyle(
              //                     fontSize: 15, 
              //                     color: Colors.grey
              //                   ),
              //                 ),
              //               ),
              //             ),
              //           ),
              //         ),
              //         //3rd Column - time
              //         Align(
              //           alignment: Alignment.centerRight,
              //           child: Container(
              //             height: 50,
              //             width: 120,
              //             child: Center(
              //               child: Row(
              //                 children: [
              //                   Icon(
              //                     Icons.watch_later,
              //                     color: Color(0xFFE86166),
              //                   ),
              //                   SizedBox(width: 10),
              //                   Text(
              //                     extractTimefromDTString(reminderDateTime),
              //                     style: TextStyle(
              //                       color: Color(0xFFE86166),
              //                       fontWeight: FontWeight.w600,
              //                       fontSize: 15,
              //                     ),
              //                   ),
              //                 ],
              //               ),
              //             ),
              //           ),
              //         ),
              //       ],
              //     ),
              //   ),
              // ),
            ),
          ),
        ),
      ),
    );
  }
}
