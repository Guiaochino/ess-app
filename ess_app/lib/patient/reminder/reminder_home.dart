import 'package:ess_app/patient/widgets/category_appbar.dart';
import 'package:ess_app/utils/colors.dart';
import "package:flutter/material.dart";
import '../widgets/main_drawer.dart';
import '../create/create_entry_reminder.dart';
import 'reminder_incoming_tab.dart';
import 'reminder_past_tab.dart';

class ReminderHomePage extends StatelessWidget {
  final int activePage;
  const ReminderHomePage({required this.activePage, super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: activePage,
      length: 2,
      child: Scaffold(
        drawer: MainDrawer(),
        floatingActionButton: FloatingActionButton.extended(
          backgroundColor: Color(0xFFF2BA05),
          foregroundColor: Colors.black,
          label: Text('Add Reminder'),
          icon: Icon(Icons.notification_add),
          onPressed: () {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => CreateEntryReminder()));
          },
        ),
        body: NestedScrollView(
          floatHeaderSlivers: true,
          headerSliverBuilder: ((context, innerBoxIsScrolled) => [
            categoryAppBar(
              title: 'Reminders',
              icon1: Icons.notifications_active,
              icon2: Icons.notifications_off,
              tabLabel1: 'INCOMING',
              tabLabel2: 'PAST',
            ),
          ]),
          body: Expanded(
            child: TabBarView(
              children: [
                ReminderIncomingTab(),
                ReminderPastTab(),
              ],
            ),
          ),
        )
      ),
    );
  }
}
