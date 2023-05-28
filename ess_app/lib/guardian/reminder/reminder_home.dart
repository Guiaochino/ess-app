import 'package:ess_app/guardian/widgets/category_tab.dart';
import 'package:ess_app/utils/colors.dart';
import 'package:ess_app/guardian/widgets/category_appbar.dart';
import "package:flutter/material.dart";
import 'package:page_transition/page_transition.dart';
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
        appBar:AppBar(
          backgroundColor: AppColors.firstColor,
          foregroundColor: Colors.black,
          centerTitle: true,
          title: Text(
            'Reminder',
            style: TextStyle(
              color: Colors.black, 
              fontSize: 16,
              fontWeight: FontWeight.w600,
              letterSpacing: 1.0,
              fontFamily: 'Montserrat'
            ),
          ), 
        ),
        drawer: MainDrawer(),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Color(0xFFF2BA05),
          foregroundColor: Colors.black,
          child: Icon(Icons.notification_add),
          onPressed: () {
            Navigator.of(context).push(
              PageTransition(
                child: CreateEntryReminder(),
                type: PageTransitionType.rightToLeft,
              ),
            );
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: Theme(
          data: Theme.of(context).copyWith(
            // Set the colors of the tab bar
            tabBarTheme: TabBarTheme(
              labelColor: Colors.black, // Modify this line
              unselectedLabelColor: Colors.grey, // Modify this line
            ),
          ),
          child: Container(
            height: 60,
            child: TabBar(
              tabs: [
                Tab(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.notifications_active),
                      SizedBox(width: 8), // Adjust the spacing between icon and text
                      Text('INCOMING'),
                    ],
                  ),
                ),
                Tab(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.notifications_off),
                      SizedBox(width: 8), // Adjust the spacing between icon and text
                      Text('PAST'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        body: TabBarView(
          children: [
            ReminderIncomingTab(),
            ReminderPastTab(),
          ],
        ),
      ),
    );
  }
}
