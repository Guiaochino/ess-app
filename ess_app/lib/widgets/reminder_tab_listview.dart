import 'package:ess_app/guardian/view/view_entry_reminder.dart';
import 'package:ess_app/utils/dateTime_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../guardian/reminder/reminder_home.dart';

class ReminderTabListView extends StatelessWidget {
  final String reminderTitle;
  final String reminderDateTime;
  final String reminderDetails;

  ReminderTabListView({
    required this.reminderTitle,
    required this.reminderDateTime,
    required this.reminderDetails,
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
              onPressed: ((context) {
                //edit
              }),
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
              onPressed: ((context) {
                //delete
              }),
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
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: MaterialButton(
            onPressed: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => ViewReminder()));
            },
            child: Container(
              height: 250,
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(20),
              ),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      //1st column - icon and title
                      Container(
                        height: 50,
                        child: Row(
                          children: [
                            Icon(
                              Icons.drive_file_rename_outline,
                              size: 50,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20.0, 
                                vertical: 5.0,
                              ),
                              child: Container(
                                width: 5,
                                height: 50,
                                color: Colors.black,
                              ),
                            ),
                            Expanded(
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  reminderTitle,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 25, 
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      //2nd Column -  diary details
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 10.0, 
                            horizontal: 10.0
                          ),
                          child: Container(
                            child: Container(
                              child: Text(
                                reminderDetails,
                                maxLines: 4,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.justify,
                                style: TextStyle(
                                  fontSize: 15, 
                                  color: Colors.grey
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      //3rd Column - time
                      Align(
                        alignment: Alignment.centerRight,
                        child: Container(
                          height: 50,
                          width: 120,
                          child: Center(
                            child: Row(
                              children: [
                                Icon(
                                  Icons.watch_later,
                                  color: Color(0xFFE86166),
                                ),
                                SizedBox(width: 10),
                                Text(
                                  extractTimefromDTString(reminderDateTime),
                                  style: TextStyle(
                                    color: Color(0xFFE86166),
                                    fontWeight: FontWeight.w600,
                                    fontSize: 15,
                                  ),
                                ),
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
        ),
      ),
    );
  }
}
