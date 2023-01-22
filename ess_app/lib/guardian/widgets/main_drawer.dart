import 'package:ess_app/guardian/memory/memory_home_page.dart';
import 'package:ess_app/utils/colors.dart';
import 'package:flutter/material.dart';
import '../home/home_page.dart';
import '../reminder/reminder_home.dart';
import '../schedule/schedule_home.dart';
import '../settings/settings_home.dart';

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
              color: AppColors.firstColor,
              child: DrawerHeader(
                child: Image.asset(
                  'assets/images/geriAssisTransparent.png',
                  fit: BoxFit.cover,
                )
                // Center(
                //     child: Text(
                //   'G e r i A s s i s',
                //   style: TextStyle(
                //     fontSize: 30,
                //     fontFamily: 'Montserrat',
                //     fontWeight: FontWeight.w800,
                //     color: Colors.black,
                //   ),
                // )),
              ),
            ),
            SizedBox(height: 10),
            drawerTile(
              icon: Icons.home, 
              title: 'Home', 
              navigation: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => guardianHomePage()));
              },
            ),
            SizedBox(height: 10),
            drawerTile(
              icon: Icons.photo_album, 
              title: 'Memories', 
              navigation: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => MemoryHomePage(activePage: 0,)));
              },
            ),
            SizedBox(height: 10),
            drawerTile(
              icon: Icons.calendar_month, 
              title: 'Schedules', 
              navigation: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => ScheduleHomePage()));
              },
            ),
            SizedBox(height: 10),
            drawerTile(
              icon: Icons.checklist, 
              title: 'Reminders', 
              navigation: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => ReminderHomePage(activePage: 0,)));
              },
            ),
            SizedBox(height: 10.0),
            Container(height: 1.0, color: Colors.grey[600]),
            SizedBox(height: 10.0),
            drawerTile(
              icon: Icons.settings, 
              title: 'Settings', 
              navigation: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => SettingsHomePage()));
              },
            ),
          ],
        ),
      ),
    );
  }
}

class drawerTile extends StatelessWidget {
  final String title;
  final IconData icon;
  final Function()? navigation;
  const drawerTile({
    Key? key, required this.title, required this.icon, required this.navigation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      selectedColor: AppColors.firstColor,
      selectedTileColor: AppColors.firstColor.withOpacity(0.1),
      leading: Icon(
        icon,
        size: 35,
        color: Colors.black,
      ),
      minLeadingWidth: 40,
      title: Text(
        title,
        style: TextStyle(
          fontSize: 20, 
          fontWeight: FontWeight.w600,
        ),
      ),
      onTap: navigation
    );
  }
}
