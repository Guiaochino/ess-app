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
  final int currentPage;
  const MainDrawer({super.key, required this.currentPage});

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
            Divider(),
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
              isSelected: currentPage == 0,
            ),
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
              isSelected: currentPage == 1,
            ),
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
              isSelected: currentPage == 2,
            ),
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
              isSelected: currentPage == 3,
            ),
            Divider(
              thickness: 1,
            ),
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
              isSelected: currentPage == 4,
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
  final bool isSelected;
  final Function()? navigation;

  const drawerTile({
    Key? key,
    required this.title,
    required this.icon,
    required this.navigation,
    required this.isSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: ListTile(
        selected: true,
        leading: Icon(
          icon,
          size: 24,
          color: Colors.black,
        ),
        title: Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        trailing: Container(
          width: 5,
          height: 30,
          decoration: BoxDecoration(
            color: isSelected ? AppColors.secondColor : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        onTap: navigation,
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      ),
    );
  }
}
