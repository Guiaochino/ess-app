import 'package:ess_app/constants.dart';
import 'package:ess_app/guardian/home/patient_home.dart';
import 'package:ess_app/guardian/memory/memory_home_page.dart';
import 'package:ess_app/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import '../home/guardian_home.dart';
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
              ),
            ),
            SizedBox(height: 10),
            drawerTile(
              icon: Icons.home, 
              title: 'Home', 
              navigation: () {
                if (userPreference == guardianPreference) {
                  Navigator.of(context).push(
                    PageTransition(
                      child: guardianHomePage(),
                      type: PageTransitionType.rightToLeft,
                    ),
                  );
                } else {
                  Navigator.of(context).push(
                    PageTransition(
                      child: patientHomePage(),
                      type: PageTransitionType.rightToLeft,
                    ),
                  );
                }
              },
            ),
            SizedBox(height: 10),
            drawerTile(
              icon: Icons.photo_album, 
              title: 'Memories', 
              navigation: () {
                Navigator.of(context).push(
                  PageTransition(
                    child: MemoryHomePage(activePage: 0),
                    type: PageTransitionType.rightToLeft,
                  ),
                );
              },
            ),
            SizedBox(height: 10),
            drawerTile(
              icon: Icons.calendar_month, 
              title: 'Schedules', 
              navigation: () {
                Navigator.of(context).push(
                  PageTransition(
                    child: ScheduleHomePage(),
                    type: PageTransitionType.rightToLeft,
                  ),
                );
              },
            ),
            SizedBox(height: 10),
            drawerTile(
              icon: Icons.checklist, 
              title: 'Reminders', 
              navigation: () {
                Navigator.of(context).push(
                  PageTransition(
                    child: ReminderHomePage(activePage: 0),
                    type: PageTransitionType.rightToLeft,
                  ),
                );
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
                  PageTransition(
                    child: SettingsHomePage(),
                    type: PageTransitionType.rightToLeft,
                  ),
                );
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
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: ListTile(
        selectedColor: AppColors.firstColor,
        selectedTileColor: AppColors.firstColor.withOpacity(0.1),
        leading: Icon(
          icon,
          size: 30,
          color: Colors.black,
        ),
        minLeadingWidth: 40,
        title: Text(
          title,
          style: TextStyle(
            fontSize: 15, 
            fontWeight: FontWeight.w600,
          ),
        ),
        onTap: navigation
      ),
    );
  }
}
