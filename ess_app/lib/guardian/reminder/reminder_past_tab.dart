import 'package:flutter/material.dart';
import '../../dataList/reminders.dart';
import '../../widgets/reminder_tab_listview.dart';

class ReminderPastTab extends StatefulWidget {
  const ReminderPastTab({super.key});

  @override
  State<ReminderPastTab> createState() => _ReminderPastTabState();
}

class _ReminderPastTabState extends State<ReminderPastTab> {
  List<Reminder> reminders = ReminderList.where((i) => i.reminderIsDone).toList();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[300],
        ),
        child: Column(
          children: [
          //container for gridview
            Expanded(
              child: Container(
                child: ListView.builder(
                  itemCount: reminders.length,
                  itemBuilder: ((context, index) {
                    final reminder = reminders[index];
                    return ReminderTabListView(
                      reminderTitle: reminder.reminderTitle,
                      reminderDateTime: reminder.reminderDateTime,
                      reminderDetails: reminder.reminderDetails,
                    );
                  }),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}