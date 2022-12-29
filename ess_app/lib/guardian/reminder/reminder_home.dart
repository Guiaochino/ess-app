import "package:flutter/material.dart";
import '../../widgets/main_drawer.dart';
import '../create/create_entry_reminder.dart';
import 'reminder_incoming_tab.dart';
import 'reminder_past_tab.dart';

class ReminderHomePage extends StatelessWidget {
  const ReminderHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Reminders',
            style: TextStyle(
              color: Colors.black, 
              fontWeight: FontWeight.w700,
              fontSize: 25.0,
              letterSpacing: 2.0,
            ),
          ),
          backgroundColor: Color.fromARGB(255, 255, 197, 6),
          foregroundColor: Colors.black,
          centerTitle: true,
        ),
        drawer: MainDrawer(),
        floatingActionButton: FloatingActionButton.extended(
          backgroundColor: Color(0xFFF2BA05),
          foregroundColor: Colors.black,
          label: Text('Add Reminder'),
          icon: Icon(Icons.notification_add),
          onPressed: () {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => CreateReminder()));
          },
        ),
        body: Column(
          children: [
            TabBar(
              unselectedLabelStyle: TextStyle(
                fontWeight: FontWeight.w500,
                letterSpacing: 2.0,
              ),
              unselectedLabelColor: Colors.grey[600],
              automaticIndicatorColorAdjustment: true,
              indicatorWeight: 5.0,
              indicatorSize: TabBarIndicatorSize.tab,
              indicatorColor: Color(0xFFF2BA05),
              tabs: [
                Tab(
                  height: 90,
                  icon: Icon(
                    Icons.notifications_active,
                    color: Colors.black,
                    size: 30,
                  ),
                  text: 'INCOMING',
                ),
                Tab(
                  height: 90,
                  icon: Icon(
                    Icons.notifications_off,
                    color: Colors.black,
                    size: 30,
                  ),
                  text: 'PAST',
                ),
              ],
              labelColor: Colors.black,
              labelStyle: TextStyle(
                fontWeight: FontWeight.w700,
                letterSpacing: 10.0,
              ),
            ),
            Expanded(
              child: TabBarView(
                children: [
                  ReminderIncomingTab(),
                  ReminderPastTab(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
