import 'package:ess_app/utils/colors.dart';
import "package:flutter/material.dart";
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:page_transition/page_transition.dart';
import 'package:ess_app/guardian/widgets/main_drawer.dart';
import 'package:ess_app/guardian/create/create_entry_diary.dart';
import 'package:ess_app/guardian/create/create_entry_image.dart';
import 'memory_diary_tab.dart';
import 'memory_image_tab.dart';

class MemoryHomePage extends StatelessWidget {
  final int activePage;

  const MemoryHomePage({required this.activePage, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: activePage,
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: AppColors.firstColor,
          foregroundColor: Colors.black,
          centerTitle: true,
          title: const Text(
            'Memory',
            style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
                fontFamily: 'Montserrat',
                color: Colors.black),
          ),
        ),
        drawer: MainDrawer(currentPage: 1,),
        floatingActionButton: SpeedDial(
          animatedIcon: AnimatedIcons.menu_close,
          backgroundColor: Color.fromARGB(255, 255, 197, 6),
          foregroundColor: Colors.black,
          overlayColor: Colors.black,
          overlayOpacity: 0.5,
          spacing: 12,
          switchLabelPosition: true,
          children: [
            SpeedDialChild(
              child: Icon(
                Icons.add_a_photo,
                color: Colors.white,
              ),
              label: 'Add Image',
              backgroundColor: Colors.grey[800],
              onTap: () {
                Navigator.of(context).push(
                  PageTransition(
                    child: CreateEntryImage(),
                    type: PageTransitionType.rightToLeft,
                  ),
                );
              },
              // onTap: () => add image function
            ),
            SpeedDialChild(
              child: Icon(Icons.note_add, 
                color: Colors.white,
              ),
              label: 'Add Diary',
              backgroundColor: Colors.grey[800],
              onTap: () {
                Navigator.of(context).push(
                  PageTransition(
                    child: CreateEntryDiary(),
                    type: PageTransitionType.rightToLeft,
                  ),
                );
              },
            )
          ],
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
                      Icon(Icons.photo_library),
                      SizedBox(width: 8), // Adjust the spacing between icon and text
                      Text('IMAGES'),
                    ],
                  ),
                ),
                Tab(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.book_rounded),
                      SizedBox(width: 8), // Adjust the spacing between icon and text
                      Text('DIARY'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        body: TabBarView(
          children: [
            MemoryImageTab(),
            MemoryDiaryTab(),
          ],
        ),
      ),
    );
  }
}
