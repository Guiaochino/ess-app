import "package:flutter/material.dart";
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import '../../widgets/main_drawer.dart';
import '../create/create_entry_diary.dart';
import '../create/create_entry_image.dart';
import 'memory_diary_tab.dart';
import 'memory_image_tab.dart';

class MemoryHomePage extends StatelessWidget {
  const MemoryHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
              'Memory',
              style: TextStyle(
                color: Colors.black, 
                fontWeight: FontWeight.w700,
                fontSize: 25.0,
                letterSpacing: 2.0
              ),
            ),
          backgroundColor: Color.fromARGB(255, 255, 197, 6),
          foregroundColor: Colors.black,
          centerTitle: true,
        ),
        drawer: MainDrawer(),
        floatingActionButton: SpeedDial(
          animatedIcon: AnimatedIcons.menu_close,
          backgroundColor: Color(0xFFF2BA05),
          foregroundColor: Colors.black,
          overlayColor: Colors.black,
          overlayOpacity: 0.5,
          spacing: 12,
          children: [
            SpeedDialChild(
              child: Icon(
                Icons.add_a_photo,
                color: Colors.white,
              ),
              label: 'Add Image',
              backgroundColor: Colors.grey[800],

              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => CreateEntryImage()));
              },
              // onTap: () => add image function
            ),
            SpeedDialChild(
              child: Icon(Icons.note_add, color: Colors.white),
              label: 'Add Diary Entry',
              backgroundColor: Colors.grey[800],
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => CreateEntryDiary()));
              },
            )
          ],
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
                    Icons.collections,
                    color: Colors.black,
                    size: 30,
                  ),
                  text: 'IMAGES',
                ),
                Tab(
                  height: 90,
                  icon: Icon(
                    Icons.my_library_books,
                    color: Colors.black,
                    size: 30,
                  ),
                  text: 'DIARY',
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
                  MemoryImageTab(),
                  MemoryDiaryTab(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
