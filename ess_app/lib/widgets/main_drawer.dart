import 'package:ess_app/guardian/memory/memory_home_page.dart';
import 'package:flutter/material.dart';

import '../guardian/home/home_page.dart';
import '../guardian/reminder/reminder_home.dart';
import '../guardian/settings/settings_home.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Color.fromARGB(255, 255, 197, 6),
      child: Container(
        child: ListView(
          children: [
            DrawerHeader(
              child: Center(
                  child: Text(
                'G e r i A s s i s',
                style: TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.w700,
                  shadows: [
                          Shadow(
                            blurRadius: 10.0,
                            color: Colors.grey,
                            offset: Offset(5.0, 5.0),
                          ),
                        ],
                ),
              )),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text(
                'Home',
                style: TextStyle(fontSize: 20),
              ),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => guardianHomePage()));
              },
            ),
            ListTile(
              leading: Icon(Icons.photo_album),
              title: Text(
                'Memories',
                style: TextStyle(fontSize: 20),
              ),
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => MemoryHomePage()));
              },
            ),
            ListTile(
              leading: Icon(Icons.calendar_month),
              title: Text(
                'Schedules',
                style: TextStyle(fontSize: 20),
              ),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => guardianHomePage()));
              },
            ),
            ListTile(
              leading: Icon(Icons.checklist),
              title: Text(
                'Reminders',
                style: TextStyle(fontSize: 20),
              ),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ReminderHomePage()));
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text(
                'Settings',
                style: TextStyle(fontSize: 20),
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
