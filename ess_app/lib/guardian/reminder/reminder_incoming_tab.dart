import 'package:ess_app/dataList/reminders.dart';
import 'package:flutter/material.dart';
import '../../widgets/reminder_tab_listview.dart';

class ReminderIncomingTab extends StatefulWidget {
  const ReminderIncomingTab({super.key});

  @override
  State<ReminderIncomingTab> createState() => _ReminderIncomingTabState();
}

class _ReminderIncomingTabState extends State<ReminderIncomingTab> {
  
  List<Reminder> reminders = ReminderList.where((i) => i.reminderIsDone == false).toList();

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
