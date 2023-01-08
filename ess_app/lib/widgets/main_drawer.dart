import 'package:ess_app/guardian/memory/memory_home_page.dart';
import 'package:flutter/material.dart';
import '../guardian/home/home_page.dart';
import '../guardian/reminder/reminder_home.dart';
import '../guardian/schedule/schedule_home.dart';
import '../guardian/settings/settings_home.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Color.fromARGB(255, 245, 242, 242),
      child: Container(
        child: ListView(
          children: [
            Container(
              color: Color(0xFFE86166),
              child: DrawerHeader(
                child: Center(
                    child: Text(
                  'G e r i A s s i s',
                  style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.w700,
                    color: Colors.white
                  ),
                )),
              ),
            ),
            SizedBox(height: 20),
            ListTile(
              leading: Icon(Icons.home,
              size: 35,
              color: Colors.black,
              ),
              minLeadingWidth: 60,
              title: Text(
                'Home',
                style: TextStyle(
                  fontSize: 20, 
                  fontWeight: FontWeight.bold
                ),
              ),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => guardianHomePage()));
              },
            ),
            SizedBox(height: 20),
            ListTile(
              leading: Icon(Icons.photo_album,
              size: 35,
              color: Colors.black,
              ),
              minLeadingWidth: 60,
              title: Text(
                'Memories',
                style: TextStyle(
                  fontSize: 20, 
                  fontWeight: FontWeight.bold
                ),
              ),
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => MemoryHomePage(activePage: 0,)));
              },
            ),
            SizedBox(height: 20),
            ListTile(
              leading: Icon(Icons.calendar_month,
              size: 35,
              color: Colors.black,
              ),
              minLeadingWidth: 60,
              title: Text(
                'Schedules',
                style: TextStyle(
                  fontSize: 20, 
                  fontWeight: FontWeight.bold
                ),
              ),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ScheduleHomePage()));
              },
            ),
            SizedBox(height: 20),
            ListTile(
              leading: Icon(Icons.checklist,
              size: 35,
              color: Colors.black,
              ),
              minLeadingWidth: 60,
              title: Text(
                'Reminders',
                style: TextStyle(
                  fontSize: 20, 
                  fontWeight: FontWeight.bold
                ),
              ),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ReminderHomePage(activePage: 0,)));
              },
            ),
            SizedBox(height: 10.0),
            Container(height: 1.0, color: Colors.grey[600]),
            SizedBox(height: 10.0),
            ListTile(
              leading: Icon(Icons.settings,
              size: 35,
              color: Colors.black,
              ),
              minLeadingWidth: 60,
              title: Text(
                'Settings',
                style: TextStyle(
                  fontSize: 20, 
                  fontWeight: FontWeight.bold
                ),
              ),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => SettingsHomePage()));
              },
            ),
          ],
        ),
      ),
    );
  }
}
